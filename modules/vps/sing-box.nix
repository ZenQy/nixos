{
  config,
  lib,
  secrets,
  ...
}:

let
  host = config.networking.hostName;
  isOptimized = host == "dmit" || host == "bwh";
  sb = secrets.sing-box;
  anytlsNode = {
    tag = "anytls";
    type = "anytls";
    listen = "::";
    listen_port = 443;
    users = [
      {
        inherit (sb.anytls) password;
      }
    ];
    tls = {
      enabled = true;
      alpn = "h2";
      acme = {
        domain = "${host}.${secrets.domain}";
        inherit (sb) dns01_challenge;
      };
    };
  };
  tuicNode = {
    tag = "tuic";
    type = "tuic";
    listen = "::";
    listen_port = 443;
    users = [
      {
        inherit (sb.tuic) uuid;
      }
    ];
    congestion_control = "bbr";
    zero_rtt_handshake = false;
    tls = {
      enabled = true;
      alpn = "h3";
      acme = {
        domain = "${host}.${secrets.domain}";
        inherit (sb) dns01_challenge;
      };
    };
  };
  log = {
    disabled = false;
    level = "info";
    timestamp = true;
  };
  inbounds = if isOptimized then [ anytlsNode ] else [ tuicNode ];
  outbounds = [ { type = "direct"; } ];
in
{
  services.sing-box = {
    enable = lib.mkDefault true;
    settings = {
      inherit log inbounds outbounds;
    };
  };
}
