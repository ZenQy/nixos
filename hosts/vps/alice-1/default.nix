{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.alice-1.ipv6.ip
    ];
    routes = [
      {
        Gateway = secrets.alice-1.ipv6.gateway;
        GatewayOnLink = true;
      }
    ];
  };

}
