{ ... }:

{

  systemd.network.networks = {
    wan = {
      name = "eth0";
      networkConfig = {
        Address = "192.168.1.11/24";
      };
    };

    lan = {
      name = "eth1";
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

}

# 网卡:
# 1.
# 类型: gmac
# 网卡名称: YT8531 Gigabit Ethernet
# 驱动: /sys/devices/platform/ffbe0000.ethernet/
# 2.
# 类型:pcie
# 网卡名称:8168
# 驱动:
# 01:00.0 "Class 0200" "10ec" "8168" "10ec" "0123" "r8168"
# 00:00.0 "Class 0604" "1d87" "3528" "0000" "0000" "pcieport"
# /sys/kernel/btf/r8168
# /sys/bus/pci/drivers/r8168
# /sys/module/r8168
# /sys/module/r8168/drivers/pci:r8168
