{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      "142.171.46.202/25"
      "2607:f130:0000:015c::f81b:3660/64"
    ];
    gateway = [
      "142.171.46.129"
      "2607:f130:0000:015c::1"
    ];
    DHCP = "no";
    extraConfig = "IPv6AcceptRA=no";
  };

  zenith.cachix.enable = true;
}
