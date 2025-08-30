{ ... }:

{
  networking.nftables = {
    enable = true;
    checkRuleset = false;
    tables = {
      filter = {
        name = "filter";
        family = "inet";
        content = ''
          chain forward {
            type filter hook forward priority 0;
            oifname "ppp0" tcp flags syn tcp option maxseg size set rt mtu #自动设置数据包的mtu大小，否则会遇到比如优酷视频加载不了的问题。
          }
        '';
      };

      nat = {
        name = "nat";
        family = "inet";
        content = ''
          chain postrouting {
            type nat hook postrouting priority srcnat; policy accept;
            masquerade #将lan浏量转发到ppp0，这么说不知道对不对，反正不设接到软路由的设备就不能访问外网。
          }
        '';
      };
    };
  };
}
