{ config, ... }:

{
  networking.nftables = {
    enable = true;
    checkRuleset = false;
    tables =
      let
        pppoe = config.systemd.network.networks.pppoe.name;
        wan = config.systemd.network.networks.wan.name;
        ping6 = "iifname \"${pppoe}\" ip6 nexthdr icmpv6 icmpv6 type echo-request";
      in
      {
        filter = {
          family = "inet";
          content = ''
            chain input {
              type filter hook input priority filter; policy accept;
              ${ping6} limit rate over 5/minute counter drop
            }
            chain forward {
              type filter hook forward priority filter; policy accept;
              ${ping6} limit rate over 5/minute counter drop
              # 自动设置数据包的mtu大小，否则可能无法加载视频。
              oifname "${pppoe}" tcp flags syn tcp option maxseg size set rt mtu counter
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

      };
  };

}
