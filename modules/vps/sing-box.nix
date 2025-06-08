{
  config,
  lib,
  secrets,
  ...
}:

let
  host = config.networking.hostName;
  isAlice = host == "alice";
  log = {
    disabled = false;
    level = "warn";
    timestamp = true;
  };
  inbounds = [
    {
      type = "trojan";
      listen = "::";
      listen_port = 443;
      users = [
        {
          inherit (secrets.sing-box.trojan) password;
        }
      ];
      tls = {
        enabled = true;
        alpn = [ "h2" ];
        acme = {
          domain = "${host}.${secrets.domain}";
          email = "zenqy.qin@gmail.com";
        };
      };
      transport = {
        type = "ws";
        inherit (secrets.sing-box.trojan) path;
      };
      multiplex.enabled = true;
    }
  ];
  outbounds =
    if isAlice then
      [
        {
          type = "socks";
          tag = "socks";
          server = "2a14:67c0:116::1";
          server_port = 10000;
          version = "5";
          username = "alice";
          password = "alicefofo123..OVO";
        }
        {
          type = "direct";
          tag = "direct";
        }
      ]
    else
      [
        {
          type = "direct";
        }
      ];
  route = {
    rules = [
      {
        ip_version = 4;
        outbound = "socks";
      }
      {
        ip_version = 6;
        outbound = "direct";
      }
    ];
  };

in
{
  services.sing-box = {
    enable = lib.mkDefault true;
    settings = {
      inherit log inbounds outbounds;
    } // (if isAlice then { inherit route; } else { });
  };
}
