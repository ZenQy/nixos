{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    networkConfig.DHCP = true;
  };

}
