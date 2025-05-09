{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  # systemd.network.networks = {
  #   eth0 = {
  #     name = "eth0";
  #     address = [
  #       "10.0.0.16/24"
  #     ];
  #     gateway = [
  #       "10.0.0.1"
  #     ];
  #   };
  #   eth1 = {
  #     name = "eth1";
  #     address = [
  #       "10.0.0.18/24"
  #     ];
  #     gateway = [
  #       "10.0.0.1"
  #     ];
  #   };
  # };

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
      address = [
        "10.0.0.18/24"
      ];
      gateway = [
        "10.0.0.1"
      ];
      DHCP = "ipv6";
    };
  };

  services.pppd = {
    enable = true;
    peers.pppoe.config = ''
      plugin pppoe.so eth0

      name 12345678901  # 账号
      password Iampasswd  # 密码
      ifname pppoe-wan

      usepeerdns
      defaultroute  # v4默认路由
    '';
  };

}
