{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network = {
    netdevs = {
      ipv6net = {
        netdevConfig = {
          Name = "ipv6net";
          Kind = "sit";
        };
        tunnelConfig = {
          inherit (secrets.hosts.bwh.ipv4) Local Remote;
          Independent = true;
          TTL = 255;
        };
      };
    };

    networks = {
      eth0 = {
        name = "eth0";
        networkConfig.DHCP = true;
      };
      ipv6net = {
        name = "ipv6net";
        networkConfig = {
          Address = secrets.hosts.bwh.ipv6.ip;
        };
        routes = [
          {
            Destination = "::/0";
            Gateway = secrets.hosts.bwh.ipv6.gateway;
            GatewayOnLink = true;
          }
        ];
      };
    };
  };

}
