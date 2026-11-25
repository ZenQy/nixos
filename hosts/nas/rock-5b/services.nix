{ pkgs, ... }:

{
  zenith = {
    aria2.enable = true;
    # freellmapi.enable = true;
    openlist.enable = true;
    podman.qd.enable = true;
    # podman.qinglong.enable = true;
    rtp2httpd.enable = true;
    # rclone = {
    #   enable = true;
    #   path = [
    #     {
    #       source = "/var/lib/openlist/data/";
    #       dest = "/rock-5b/openlist";
    #       include = [
    #         "config.json"
    #         "data.db*"
    #       ];
    #     }
    #     # {
    #     #   source = "/var/lib/freellmapi/data/";
    #     #   dest = "/rock-5b/freellmapi";
    #     #   include = [
    #     #     "freeapi.db"
    #     #     "freeapi.db-shm"
    #     #     "freeapi.db-wal"
    #     #   ];
    #     # }
    #     {
    #       source = "/var/lib/containers/storage/volumes/qd/_data/";
    #       dest = "/rock-5b/qd";
    #       include = [
    #         "database.db"
    #       ];
    #     }
    #   ];
    # };
  };

  services.caddy = {
    enable = true;
    extraConfig = ''

      :80 {
        root * ${./conf/caddy}
        file_server
      }

      :443 {
        tls internal
        reverse_proxy :5244
      }

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

  systemd.timers = {
    traffic-consumer = {
      enable = true;
      timerConfig.OnCalendar = "*-*-* 01..07:0/3:00";
      wantedBy = [ "timers.target" ];
    };
    tv-m3u = {
      enable = true;
      timerConfig.OnCalendar = "Fri *-*-* 04:00:00";
      wantedBy = [ "timers.target" ];
    };
  };
  systemd.services = {
    traffic-consumer = {
      enable = true;
      serviceConfig.ExecStart = ''
        ${pkgs.curl}/bin/curl -so /dev/null https://f.940940.xyz/alcie.raw.gz
      '';
    };
    tv-m3u = {
      enable = true;
      path = with pkgs; [
        curl
        jq
      ];
      serviceConfig = {
        User = "nixos";
        Group = "wheel";
      };
      script = ''
        echo "#EXTM3U" > /storage/tv.m3u
        URL="https://www.wmviv.com/iptv/ahmoiptv.json?v=$(date +%s)&file=ahmoiptv"
        curl -s "$URL" | \
          jq -r '.channels.[] | "#EXTINF:-1 group-title=\"\(."频道分类")\",\(."频道名称")-\(."清晰度")\n\(."播放地址")"' \
          >> /storage/tv.m3u
      '';
    };
  };
}
