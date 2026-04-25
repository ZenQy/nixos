{ pkgs, ... }:

{
  zenith = {
    aria2.enable = true;
    openlist.enable = true;
    rtp2httpd.enable = true;
    podman.metapi.enable = true;
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

  services.cron = {
    enable = true;
    systemCronJobs =
      let
        tv-m3u.sh = pkgs.writeShellScript "tv-m3u.sh" ''
          echo "#EXTM3U" > /storage/tv.m3u
          URL="https://www.wmviv.com/anhui-mobile-iptv.html"
          count=1
          curl -s "$URL" | ${pkgs.pup}/bin/pup 'table td text{}' | while read -r cell_data; do
              case $count in
                  1) val1=$cell_data ;;
                  2) val2=$cell_data ;;
                  4) val4=$cell_data ;;
              esac
              if [ $count -eq 5 ]; then
                  echo "#EXTINF:-1 group-title=\"$val2\",$val1" >> /storage/tv.m3u
                  echo "$val4" >> /storage/tv.m3u
                  count=1
              else
                  ((count++))
              fi
          done
        '';
      in
      [
        # 更新 tv.m3u
        "0 4 * * 3 nixos ${tv-m3u.sh}"
        # 下载消耗流量
        "*/5 1-6 * * * nixos ${pkgs.curl}/bin/curl -so /dev/null https://940940.xyz/alcie.raw.gz"
      ];
  };
}
