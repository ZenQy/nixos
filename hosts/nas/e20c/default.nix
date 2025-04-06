{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks = {
    eth0 = {
      name = "eth0";
      address = [
        "10.0.0.16/24"
      ];
      gateway = [
        "10.0.0.1"
      ];
    };
    eth1 = {
      matchConfig = {
        Name = "eth1";
      };
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = "no";
        LinkLocalAddressing = "no";
      };
      linkConfig = {
        inherit (secrets.tvbox) MACAddress;
      };
      dhcpV4Config = {
        RouteMetric = 20;
        inherit (secrets.tvbox) Hostname;
        inherit (secrets.tvbox) SendOption;
      };
    };
  };

}
