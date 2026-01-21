{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.hosts.wawo6.ipv4.ip
      secrets.hosts.wawo6.ipv6.ip
    ];
    routes = [
      { Gateway = secrets.hosts.wawo6.ipv4.gateway; }
      {
        Gateway = secrets.hosts.wawo6.ipv6.gateway;
        GatewayOnLink = true;
      }
    ];
  };

}
