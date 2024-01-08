{ lib, ... }:

{
  networking = {
    useDHCP = false;
    dhcpcd.enable = false;
    firewall.enable = false;
  };
  systemd.network.enable = lib.mkDefault true;
}
