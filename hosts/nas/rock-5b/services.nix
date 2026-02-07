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
      :6868 {
        root * ${pkgs.ariang}/share/ariang
        file_server browse
      }

      :8080 {
        root * /storage
        file_server browse
      }
    '';
  };
}
