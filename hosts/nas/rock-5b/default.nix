{ ... }:

{
  imports = [
    ./services.nix
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      "10.0.0.12/24"
    ];
    gateway = [
      "10.0.0.1"
    ];
    DHCP = "ipv6";
  };

}
