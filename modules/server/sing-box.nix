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
                  listen_port = secrets.sing-box.trojan.port.claw;
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
                    server_name = domain;
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
                  listen_port = secrets.sing-box.trojan.port.${config.networking.hostName};
                }
              )
            ]
        );
      outbounds = [
        {
          type = "direct";
        }
      ];
      route = {
        geosite.path = "/etc/sing-box/geosite.db";
        geoip.path = "/etc/sing-box/geoip.db";
      };
    };
  };
}
