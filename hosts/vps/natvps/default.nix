{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    routes = [
      { Gateway = secrets.hosts.natvps.ipv4.gateway; }
      {
        Gateway = secrets.hosts.natvps.ipv6.gateway;
        GatewayOnLink = true;
      }
    ];
    networkConfig = {
      Address = [
        secrets.hosts.natvps.ipv4.ip
        secrets.hosts.natvps.ipv6.ip
      ];
      DHCP = false;
      IPv6AcceptRA = false;
      LinkLocalAddressing = false;
    };
  };

  services.openssh.ports = [ 22 ];
}
