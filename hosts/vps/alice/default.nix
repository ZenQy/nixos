{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.alice.ipv6.ip
    ];
    routes = [
      {
        Gateway = secrets.alice.ipv6.gateway;
        GatewayOnLink = true;
      }
    ];
  };

}
