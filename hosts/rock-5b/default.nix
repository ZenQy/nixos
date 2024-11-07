{ ... }:

{
  imports = [
    ./services.nix
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "enP4p1s0";
    address = [ "10.0.0.11/24" ];
    gateway = [ "10.0.0.1" ];
    DHCP = "ipv6";
  };

}
