{ config, pkgs, ... }:

{
  networking.nftables =
    let
      pppoe = config.systemd.network.networks.pppoe.name;
      wan = config.systemd.network.networks.wan.name;
      lan = config.systemd.network.networks.lan.name;
    in
    {
      enable = true;
      checkRuleset = false;
      tables = {
        filter = {
          family = "inet";
          content = ''
            chain input {
              type filter hook input priority filter; policy drop;
              iifname "lo" counter accept
              ip protocol icmp counter accept
              ip6 nexthdr icmpv6 counter accept
              iifname "${pppoe}" udp dport 546 counter accept
              iifname "${lan}" counter accept
              iifname "${pppoe}" ct state { established, related } counter accept
            }
            chain forward {
              type filter hook forward priority filter; policy drop;
              # 自动设置数据包的mtu大小，否则可能无法加载视频。
              oifname "${pppoe}" tcp flags syn tcp option maxseg size set rt mtu counter
              ip protocol icmp accept
              ip6 nexthdr icmpv6 accept
              iifname "${lan}" oifname "${pppoe}" counter accept
              iifname "${pppoe}" oifname "${lan}" ct state { established, related } counter accept
            }
          '';
        };

        nat = {
          family = "ip";
          content = ''
            chain postrouting {
              type nat hook postrouting priority filter; policy accept;
              oifname "${wan}" counter masquerade # 动态伪装,局域网内访问光猫
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
