{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.hosts.alice.ipv6.ip
    ];
    routes = [
      {
        Gateway = secrets.hosts.alice.ipv6.gateway;
        GatewayOnLink = true;
      }
    ];
  };

}
