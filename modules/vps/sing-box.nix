{
  config,
  lib,
  secrets,
  ...
}:

let
  host = config.networking.hostName;
  is_vless = host == "osaka-1";
  sb = secrets.sing-box;
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
      certificate_provider = {
        type = "acme";
        domain = "${host}.${secrets.domain}";
        inherit (sb) dns01_challenge;
      };
    };
  };
  vless-nodes = {
    tag = "vless";
    type = "vless";
    listen = "::";
    listen_port = 80;
    users = [ { inherit (sb.cloudflare) uuid; } ];
    multiplex.enabled = true;
    transport = {
      type = "ws";
      path = "/";
      headers.Host = sb.cloudflare.host;
    };
    tls.enabled = false;
  };
  log = {
    level = "info";
    timestamp = true;
  };
  inbounds =
    if is_vless then
      [
        tuicNode
        vless-nodes
      ]
    else
      [ tuicNode ];
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
