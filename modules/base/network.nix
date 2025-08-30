{ lib, ... }:

{
  networking = {
    useDHCP = false;
    dhcpcd.enable = false;
    firewall.enable = lib.mkDefault false;
  };
  systemd.network.enable = lib.mkDefault true;
  services.resolved.enable = false;
}
