{ lib, ... }:

{
  networking = {
    useDHCP = false;
    dhcpcd.enable = false;
    firewall.enable = false;
    nameservers = [
      "1.1.1.1"
    ];
  };
  systemd.network.enable = lib.mkDefault true;
  services.resolved.enable = false;
}
