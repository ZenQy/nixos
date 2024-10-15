{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "ens5";
    dns = [ "8.8.8.8" ];
    DHCP = "yes";
  };
}
