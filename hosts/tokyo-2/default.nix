{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "ens3";
    DHCP = "yes";
  };

}
