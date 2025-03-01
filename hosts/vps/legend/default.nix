{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.legend.ipv4.ip
      secrets.legend.ipv6.ip
    ];
    routes = [
      { Gateway = secrets.legend.ipv4.gateway; }
      {
        Gateway = secrets.legend.ipv6.gateway;
        GatewayOnLink = true;
      }
    ];
  };
}
