{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.hosts.icmp9.ipv6.ip
    ];
    routes = [
      {
        Gateway = secrets.hosts.icmp9.ipv6.gateway;
        GatewayOnLink = true;
      }
    ];
  };

}
