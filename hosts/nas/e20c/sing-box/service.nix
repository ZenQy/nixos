{
  pkgs,
  tproxy_port,
}:

let
  table = "proxy";
  fwmark = "1";
  tableID = "100";
  ip = "${pkgs.iproute2}/bin/ip";
  nft = "${pkgs.nftables}/bin/nft";
  ip_rule = "fwmark ${fwmark} lookup ${tableID}";
  ip_route = "local default dev lo table ${tableID}";
in

{
  ExecStartPost =
    let
      inherit (builtins) concatStringsSep;
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
      reserved_IPv6 = [
        "fe80::/10"
        "240e::/18"
        "2408:8000::/20"
        "2409:8000::/20"
        "2001:da8::/32"
      ];
      user = "sing-box";
      source_MAC = [
        # beelink
        "70:70:fc:03:2c:08"
        "70:70:fc:03:2c:09"
        "0c:91:92:f2:d2:e9"
        # E20C
        "12:a9:f6:67:39:e9"
        "00:e0:4c:0d:1b:36"
        # ROCK-5B
        "00:e0:4c:68:00:7a"
        # OECT
        "d6:51:eb:55:bd:27"
      ];
      ruleset =
        chain:
        map (rule: "${nft} add rule inet ${table} ${chain} ${rule}") (
          [
            "fib daddr type local meta l4proto { tcp, udp } th dport ${tproxy_port} counter reject"
            "ip daddr { ${concatStringsSep ", " reserved_IP} } counter return"
            "ip6 daddr { ${concatStringsSep ", " reserved_IPv6} } counter return"
          ]
          ++ (
            if chain == "prerouting" then
              [
                "ether saddr != { ${concatStringsSep ", " source_MAC} } counter return"
                "meta l4proto { tcp, udp } counter tproxy to :${tproxy_port} meta mark set ${fwmark}"
              ]
            else
              [
                "meta skuid ${user} counter return"
                "meta l4proto { tcp, udp } counter meta mark set ${fwmark}"
              ]
          )
        );

      script = pkgs.writeShellScript "sing-box-post-start" ''
        ${ip} rule add ${ip_rule}
        ${ip} -6 rule add ${ip_rule}
        ${ip} route add ${ip_route}
        ${ip} -6 route add ${ip_route}

        ${nft} add table inet ${table}
        ${nft} add chain inet ${table} prerouting { type filter hook prerouting priority mangle \; policy accept \; }
        ${nft} add chain inet ${table} output { type route hook output priority mangle \; policy accept \; }

        ${concatStringsSep "\n" (ruleset "prerouting")}

        ${concatStringsSep "\n" (ruleset "output")}
      '';
    in
    "+${script}";
  ExecStopPost =
    let
      script = pkgs.writeShellScript "sing-box-post-stop" ''
        ${ip} rule del ${ip_rule}
        ${ip} -6 rule del ${ip_rule}
        ${ip} route del ${ip_route}
        ${ip} -6 route del ${ip_route}

        ${nft} delete table inet ${table}
      '';
    in
    "+${script}";
}
