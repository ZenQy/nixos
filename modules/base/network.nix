{ lib, ... }:

{
  networking = {
    useDHCP = false;
    dhcpcd.enable = false;
    firewall.enable = false;
    nameservers = [
      "1.1.1.1"
      "2606:4700:4700::1111"
    ];
  };
  systemd.network.enable = lib.mkDefault true;
  services.resolved.enable = false;
}
