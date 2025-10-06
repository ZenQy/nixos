{ pkgs, ... }:

{
  networking.nftables = {
    enable = true;
    checkRuleset = false;
    tables = {
      filter = {
        family = "inet";
        content = ''
          chain forward {
            type filter hook forward priority 0;
            oifname "ppp0" tcp flags syn tcp option maxseg size set rt mtu # 自动设置数据包的mtu大小，否则会遇到比如优酷视频加载不了的问题。
          }
        '';
      };

      nat = {
        family = "ip";
        content = ''
          chain postrouting {
            type nat hook postrouting priority srcnat; policy accept;
            masquerade # 将lan浏量转发到ppp0，这么说不知道对不对，反正不设接到软路由的设备就不能访问外网。
          }
        '';
      };

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

                fib daddr type local meta l4proto { tcp, udp } th dport ${toString tproxy_port} reject

                ip6 daddr != fc00::/18 return
                ip saddr {${concatStringsSep ", " source_IP}} return
                ip daddr {${concatStringsSep ", " reserved_IP}} return

                meta l4proto { tcp, udp } tproxy to :${toString tproxy_port} meta mark set ${toString proxy_fwmark}
            }

            chain output {
                type route hook output priority mangle; policy accept;

                fib daddr type local meta l4proto { tcp, udp } th dport ${toString tproxy_port} reject
                meta skuid ${user} return

                ip6 daddr != fc00::/18 return
                ip daddr {${concatStringsSep ", " reserved_IP}} return

                meta l4proto { tcp, udp } meta mark set ${toString proxy_fwmark}
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
