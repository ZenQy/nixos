{
  config,
  lib,
  secrets,
  ...
}:

{
  services.sing-box = {
    enable = lib.mkDefault true;
    settings = {
      log = {
        disabled = false;
        level = "warn";
        timestamp = true;
      };
      inbounds =
        let
          domain = "${config.networking.hostName}.${secrets.domain}";
          trojan = {
            type = "trojan";
            users = [
              {
                inherit (secrets.sing-box.trojan) password;
              }
            ];
            multiplex.enabled = true;
            transport = {
              type = "ws";
              path = "/${config.networking.hostName}";
            };
          };
        in
        (
          if config.networking.hostName == "claw" then
            [
              (
                trojan
                // {
                  listen = "127.0.0.1";
                  listen_port = secrets.sing-box.trojan.port;
                }
              )
            ]
          else
            [
              (
                trojan
                // {
                  listen = "::";
                  listen_port = 443;
                  tls = {
                    enabled = true;
                    alpn = [ "h2" ];
                    acme = {
                      inherit domain;
                      email = "zenqy.qin@gmail.com";
                    };
                  };
                }
              )
              (
                trojan
                // {
                  listen = "::";
                  listen_port = secrets.sing-box.trojan.port;
                }
              )
            ]
        );
      outbounds = [
        (
          if config.networking.hostName == "alice" then
            {
              type = "socks";
              server = "2a14:67c0:100::af";
              server_port = 40000;
              version = "5";
              username = "alice";
              password = "alicefofo123..@";
            }
          else
            {
              type = "direct";
            }
        )
      ];
    };
  };
}
