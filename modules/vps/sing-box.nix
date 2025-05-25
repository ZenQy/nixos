{
  config,
  lib,
  secrets,
  ...
}:

{
  services.sing-box =
    let
      host = config.networking.hostName;
      isAlice = host == "alice";
      isClaw = host == "claw";
      log = {
        disabled = false;
        level = "warn";
        timestamp = true;
      };
      inbounds =
        let
          domain = "${host}.${secrets.domain}";
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
              path = "/${host}";
            };
          };
        in
        (
          if isClaw then
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
        )
        ++ (
          if isAlice then
            [
              {
                type = "tun";
                tag = "tun-in";
                address = [
                  "172.18.0.1/24"
                  "fdfe:dcba:9876::1/64"
                ];
                mtu = 1500;
                auto_route = true;
                strict_route = false;
                stack = "gvisor";
              }
            ]
          else
            [ ]
        );
      outbounds =
        if isAlice then
          [
            {
              type = "socks";
              tag = "socks";
              server = "2a14:67c0:100::af";
              server_port = 40000;
              version = "5";
              username = "alice";
              password = "alicefofo123..@";
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
      enable = lib.mkDefault true;
      settings = {
        inherit log inbounds outbounds;
      } // (if isAlice then { inherit route; } else { });
    };
}
