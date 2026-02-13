{ pkgs, ... }:

{
  zenith.aria2.enable = true;
  zenith.openlist.enable = true;
  zenith.podman.qd.enable = true;
  zenith.rclone = {
    enable = true;
    path = [
      {
        source = "/var/lib/openlist/data/";
        dest = "/rock-5b/openlist";
        include = [
          "config.json"
          "data.db*"
        ];
      }
      {
        source = "/var/lib/containers/storage/volumes/qd/_data/";
        dest = "/rock-5b/qd";
        include = [
          "database.db"
        ];
      }
    ];
  };

  services.flaresolverr.enable = true;
  services.caddy = {
    enable = true;
    extraConfig = ''
      http://aria.lan {
        root * ${pkgs.ariang}/share/ariang
        file_server browse
      }

      http://file.lan {
        root * /storage
        file_server browse
      }

      http://dns.lan {
        reverse_proxy 10.0.0.1:3000
      }

      http://sb.lan {
        reverse_proxy 10.0.0.1:9090
      }

      http://bt.lan {
        reverse_proxy 10.0.0.15:9091 {
          header_up Host localhost
        }
      }

      pan.lan {
        tls internal
        reverse_proxy :5244
      }

      http://pan1.lan {
        reverse_proxy :5244
      }

      http://pan2.lan {
        reverse_proxy 10.0.0.15:5244
      }
    '';
  };
}
