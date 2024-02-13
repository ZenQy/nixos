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
      inbounds = [
        {
          type = "tuic";
          listen = "::";
          listen_port = 443;
          users = [
            {
              uuid = secrets.sing-box.tuic.uuid;
              password = secrets.sing-box.tuic.password;
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
        }
      ];
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
















