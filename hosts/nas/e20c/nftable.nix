{ config, pkgs, ... }:

{
  networking.nftables = {
    enable = true;
    checkRuleset = false;
    tables = {
      filter = {
        family = "inet";
        content = ''
          chain forward {
            type filter hook forward priority filter; policy accept;
            # 自动设置数据包的mtu大小，否则可能无法加载视频。
            oifname "${config.systemd.network.networks.pppoe.name}" tcp flags syn tcp option maxseg size set rt mtu counter
          }
        '';
      };

      # 使用einat后删除
      # nat = {
      #   family = "ip";
      #   content = ''
      #     chain postrouting {
      #       type nat hook postrouting priority filter; policy accept;
      #       oifname "ppp0" counter masquerade # ipv4 动态伪装
      #     }
      #   '';
      # };

      proxy = {
        family = "inet";
        content =
          let
            reserved_IP = [
              "127.0.0.0/8"
              "10.0.0.0/16"
              "192.168.0.0/16"
              "100.64.0.0/10"
              "169.254.0.0/16"
              "172.16.0.0/12"
              "224.0.0.0/4"
              "240.0.0.0/4"
              "255.255.255.255/32"
            ];
            source_IP = [ "10.0.0.128/25" ];
            tproxy_port = 12345;
            proxy_fwmark = 1;
            user = "sing-box";
          in
          with builtins;
          ''
            chain prerouting {
                type filter hook prerouting priority mangle; policy accept;

                fib daddr type local meta l4proto { tcp, udp } th dport ${toString tproxy_port} counter reject

                ip6 daddr != fc00::/18 counter return
                ip saddr {${concatStringsSep ", " source_IP}} counter return
                ip daddr {${concatStringsSep ", " reserved_IP}} counter return

                meta l4proto { tcp, udp } counter tproxy to :${toString tproxy_port} meta mark set ${toString proxy_fwmark}
            }

            chain output {
                type route hook output priority mangle; policy accept;

                fib daddr type local meta l4proto { tcp, udp } th dport ${toString tproxy_port} counter reject
                meta skuid ${user} counter return

                ip6 daddr != fc00::/18 counter return
                ip daddr {${concatStringsSep ", " reserved_IP}} counter return

                meta l4proto { tcp, udp } counter meta mark set ${toString proxy_fwmark}
            }
          '';
      };
    };
  };

  systemd.services.sing-box.serviceConfig = {
    ExecStartPost =
      let
        script = pkgs.writeShellScript "sing-box-post-start" ''
          ${pkgs.iproute2}/bin/ip rule add fwmark 0x1 lookup 100
          ${pkgs.iproute2}/bin/ip route add local default dev lo table 100
          ${pkgs.iproute2}/bin/ip -6 rule add fwmark 0x1 lookup 100
          ${pkgs.iproute2}/bin/ip -6 route add local default dev lo table 100
        '';
      in
      "+${script}";
    ExecStopPost =
      let
        script = pkgs.writeShellScript "sing-box-post-stop" ''
          ${pkgs.iproute2}/bin/ip rule del fwmark 0x1 lookup 100
          ${pkgs.iproute2}/bin/ip route del local default dev lo table 100
          ${pkgs.iproute2}/bin/ip -6 rule del fwmark 0x1 lookup 100
          ${pkgs.iproute2}/bin/ip -6 route del local default dev lo table 100
        '';
      in
      "+${script}";
  };

}
