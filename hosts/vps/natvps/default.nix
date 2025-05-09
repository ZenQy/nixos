{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      secrets.hosts.natvps.ipv4.ip
      secrets.hosts.natvps.ipv6.ip
    ];
    routes = [
      { Gateway = secrets.hosts.natvps.ipv4.gateway; }
      {
        Gateway = secrets.hosts.natvps.ipv6.gateway;
        GatewayOnLink = true;
      }
    ];
    DHCP = "no";
    networkConfig = {
      IPv6AcceptRA = "no";
      LinkLocalAddressing = "no";
    };
  };

  services.openssh.ports = [ 22 ];
}
