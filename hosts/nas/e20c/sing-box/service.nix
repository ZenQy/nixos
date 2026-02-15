{
  pkgs,
  fake_ipv6,
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
      source_IP = [ "10.0.0.128/25" ];
      user = "sing-box";
      ruleset =
        chain:
        map (rule: "${nft} add rule inet ${table} ${chain} ${rule}") (
          [
            "fib daddr type local meta l4proto { tcp, udp } th dport ${tproxy_port} counter reject"
            "ip6 daddr != ${fake_ipv6} counter return"
            "ip daddr { ${concatStringsSep ", " reserved_IP} } counter return"
          ]
          ++ (
            if chain == "prerouting" then
              [
                "ip saddr { ${concatStringsSep ", " source_IP} } counter return"
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
