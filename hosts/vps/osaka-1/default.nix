{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.eth0 = {
    name = "eth0";
    networkConfig.DHCP = true;
  };

}
