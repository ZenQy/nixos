{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.hosts.sailor.ipv4.ip
      # secrets.hosts.sailor.ipv6.ip
    ];
    routes = [
      { Gateway = secrets.hosts.sailor.ipv4.gateway; }
      # {
      #   Gateway = secrets.hosts.sailor.ipv6.gateway;
      #   GatewayOnLink = true;
      # }
    ];
  };
}
