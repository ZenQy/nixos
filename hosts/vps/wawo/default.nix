{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.hosts.wawo.ipv4.ip
      secrets.hosts.wawo.ipv6.ip
    ];
    routes = [
      { Gateway = secrets.hosts.wawo.ipv4.gateway; }
      {
        Gateway = secrets.hosts.wawo.ipv6.gateway;
        GatewayOnLink = true;
      }
    ];
  };

}
