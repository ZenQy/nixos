{ secrets, ... }:

{

  systemd.network.networks = {
    wan = {
      name = "eth1";
      networkConfig = {
        Address = "192.168.1.11/24";
      };
    };

    lan = {
      name = "eth0";
      networkConfig = {
        Address = "10.0.0.1/24";
        DHCP = "ipv6";
        DHCPPrefixDelegation = true; # 自动选择第一个有 PD 的链路, 并获得子网前缀
        IPv6SendRA = true; # 会自动关闭 IPv6AcceptRA 并打开 IPv6Forwarding
        DHCPServer = true;
      };
      dhcpServerConfig = {
        PoolOffset = 150;
        PoolSize = 100;
        EmitDNS = true;
        DNS = "10.0.0.1";
      };
    };

    ppp0 = {
      name = "ppp0";
      networkConfig = {
        DHCP = "ipv6"; # 需要先接收到包含 M Flag 的 RA 才会尝试 DHCP-PD
        KeepConfiguration = "static"; # 防止清除 PPPD 通过 IPCP 获取的 IPV4 地址
        DefaultRouteOnDevice = true; # 设置默认路由到该接口
      };
      dhcpV6Config = {
        UseAddress = false; # 使用 SLAAC
        UseDNS = false;
      };
      ipv6AcceptRAConfig.DHCPv6Client = "always";
    };
  };

  services.pppd = {
    enable = true;
    peers.pppoe.config = ''
      plugin pppoe.so eth1

      name "${secrets.pppoe.username}"
      password "${secrets.pppoe.password}"

      persist
      maxfail 0
      holdoff 5

      noipdefault
      defaultroute
    '';
  };

}
