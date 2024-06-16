{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "ens3";
    dns = [ "8.8.8.8" ];
    DHCP = "yes";
  };

}
