{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "ens3";
    address = secrets.cloudcone.address;
    gateway = secrets.cloudcone.gateway;
    DHCP = "no";
    extraConfig = "IPv6AcceptRA=no";
  };

  zenith.cachix.enable = true;
}
