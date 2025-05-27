{ lib, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    networkConfig.DHCP = true;
  };

  zenith.podman.traffmonetizer.enable = lib.mkForce false;
}
