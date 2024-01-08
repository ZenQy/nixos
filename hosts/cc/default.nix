{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "ens3";
    address = secrets.cloudcone.address;
    gateway = secrets.cloudcone.gateway;
    dns = [ "8.8.8.8" "2001:4860:4860::8888" ];
    DHCP = "no";
    extraConfig = "IPv6AcceptRA=no";
  };

  services.cachix.enable = true;
}
