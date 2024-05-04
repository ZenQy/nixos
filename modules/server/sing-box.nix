{ config, lib, secrets, ... }:

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
          tuic = {
            type = "tuic";
            listen = "::";
            listen_port = 443;
            tcp_fast_open = true;
            users = [
              {
                inherit (secrets.sing-box.tuic) uuid password;
              }
            ];
            congestion_control = "bbr";
            tls =
              let domain = "${config.networking.hostName}.${secrets.domain}";
              in {
                enabled = true;
                server_name = domain;
                acme = {
                  inherit domain;
                  email = "zenqy.qin@gmail.com";
                };
                alpn = [ "h3" ];
              };
          };
        in
        if config.networking.hostName == "cc" then
          [
            tuic
            {
              type = "shadowsocks";
              listen = "::";
              tcp_fast_open = true;
              multiplex.enabled = true;
              listen_port = secrets.sing-box.ss.port;
              inherit (secrets.sing-box.ss) method password;
            }
          ]
        else [ tuic ];
      outbounds =
        if config.networking.hostName == "cc" then
          [
            {
              type = "direct";
            }
          ]
        else [
          {
            type = "shadowsocks";
            tcp_fast_open = true;
            multiplex.enabled = true;
            server_port = secrets.sing-box.ss.port;
            inherit (secrets.sing-box.ss) server method password;
          }
        ];
      route = {
        geosite.path = "/etc/sing-box/geosite.db";
        geoip.path = "/etc/sing-box/geoip.db";
      };
    };
  };
}
















