{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.hosts.dmit.ipv4.ip
    ];
    routes = [
      {
        Gateway = secrets.hosts.dmit.ipv4.gateway;
        GatewayOnLink = true;
      }
    ];
  };

}
