{ ... }:

{
  imports = [
    ./services.nix
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "enP4p1s0";
    address = [ "10.0.0.8/24" ];
    gateway = [ "10.0.0.1" ];
    dns = [ "114.114.114.114" ];
    DHCP = "ipv6";
  };

}
