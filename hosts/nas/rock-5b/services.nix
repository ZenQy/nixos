{ pkgs, ... }:

{
  zenith = {
    aria2.enable = true;
    openlist.enable = true;
    rtp2httpd.enable = true;
    podman.qd.enable = true;
    podman.qinglong.enable = true;
    rclone = {
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
  };

  services.caddy = {
    enable = true;
    extraConfig = ''
      :6868 {
        root * ${pkgs.ariang}/share/ariang
        file_server browse
      }

      :8080 {
        root * /storage
        file_server browse
      }

      10.0.0.12 {
        tls internal
        reverse_proxy :5244
      }
    '';
  };
}
