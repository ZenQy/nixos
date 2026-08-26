{ pkgs, ... }:

{
  zenith = {
    aria2.enable = true;
    freellmapi.enable = true;
    openlist.enable = true;
    podman.qd.enable = true;
    podman.qinglong.enable = true;
    rtp2httpd.enable = true;
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
          source = "/var/lib/freellmapi/data/";
          dest = "/rock-5b/freellmapi";
          include = [
            "freeapi.db"
            "freeapi.db-shm"
            "freeapi.db-wal"
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

      :80 {
        # ==========================================
        # 智能尾斜杠补全：只为没有扩展名的目录路径加斜杠
        # ==========================================
        @needs_slash {
          not path */    # 条件1：排除已经以 / 结尾的路径
          not path *.*   # 条件2：排除包含 . 的请求（保护 .css, .js, .png 等静态文件）
        }
        redir @needs_slash {path}/

        handle_path /ariang/* {
          root * ${pkgs.ariang}/share/ariang
          file_server
        }
        handle_path /storage/* {
          root * /storage
          file_server browse
        }
        handle_path /openlist/* {
          reverse_proxy :5244
        }
        handle_path /freellmapi/* {
          reverse_proxy :3001
        }
        handle_path /qd/* {
          reverse_proxy :8923
        }
        handle_path /qinglong/* {
          reverse_proxy :5700
        }
        handle_path /rtp2httpd/* {
          reverse_proxy :5140
        }

        handle {
          root * ${./conf/caddy}
          file_server
        }
      }

      :443 {
        tls internal
        reverse_proxy :5244
      }
      # 下面的作为过渡，过段时间要记得删除
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
        pup
      ];
      serviceConfig = {
        User = "nixos";
        Group = "wheel";
      };
      script = ''
        echo "#EXTM3U" > /storage/tv.m3u
        URL="https://www.wmviv.com/anhui-mobile-iptv.html"
        count=1
        curl -s "$URL" | pup 'table td text{}' | while read -r cell_data; do
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
    };
  };
}
