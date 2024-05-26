{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "enp3s0";
    address = secrets.crunchbits.address;
    gateway = secrets.crunchbits.gateway;
    dns = [ "8.8.8.8" "2001:4860:4860::8888" ];
    DHCP = "no";
    extraConfig = "IPv6AcceptRA=no";
  };

}
