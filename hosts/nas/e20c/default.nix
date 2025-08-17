{ secrets, ... }:
# 拨号还未验证
{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks = {
    wan = {
      name = "pppoe-wan";
      networkConfig = {
        DHCP = "ipv6"; # 需要先接收到包含 M Flag 的 RA 才会尝试 DHCP-PD
        KeepConfiguration = "static"; # 防止清除 PPPD 通过 IPCP 获取的 IPV4 地址
      };
      dhcpV6Config = {
        UseDNS = false;
        WithoutRA = "solicit"; # 允许收到的 RA 不包含 M Flag 时启用 DHCP-PD
        UseAddress = false; # 无法获得到地址时需要
      };
      routes = [
        { Gateway = "0.0.0.0"; } # v4默认路由, 因为v4不是networkd管理的，所以仅在reconfigure时工作
        { Gateway = "::"; } # v6默认路由
      ];
    };

    lan = {
      name = "eth1";
      networkConfig = {
        Address = "10.0.0.18/24";
        Gateway = "10.0.0.1";
        DHCP = "ipv6";
        IPv6AcceptRA = false;
        LinkLocalAddressing = false;
        DHCPServer = true;
      };
      dhcpServerConfig = {
        PoolOffset = 100;
        PoolSize = 150;
      };
    };
  };

  services.pppd = {
    enable = true;
    peers.pppoe.config = ''
      plugin pppoe.so
      eth0

      name "${secrets.pppoe.username}"
      password "${secrets.pppoe.password}"
      ifname pppoe-wan

      +ipv6 ipv6cp-use-ipaddr

      persist
      maxfail 0
      holdoff 5

      noipdefault
      defaultroute
    '';
  };

}
