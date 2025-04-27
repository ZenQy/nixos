{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.sailor.ipv4.ip
      # secrets.sailor.ipv6.ip
    ];
    routes = [
      { Gateway = secrets.sailor.ipv4.gateway; }
      # {
      #   Gateway = secrets.sailor.ipv6.gateway;
      #   GatewayOnLink = true;
      # }
    ];
  };
}
