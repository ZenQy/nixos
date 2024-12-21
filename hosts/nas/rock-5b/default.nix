{ ... }:

{
  imports = [
    ./services.nix
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    DHCP = "yes";
  };

}
