{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      "10.0.0.11/24"
    ];
    gateway = [
      "10.0.0.1"
    ];
    DHCP = "ipv6";
  };

}
