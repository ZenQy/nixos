{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "enp3s0";
    dns = [ "8.8.8.8" ];
    DHCP = "yes";
  };

}
