{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks = {
    eth0 = {
      name = "eth0";
      DHCP = "yes";
    };
    eth1 = {
      name = "eth1";
      DHCP = "yes";
    };
  };

}
