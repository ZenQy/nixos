{ config, secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.eth0 = {
    name = "eth0";
    networkConfig =
      let
        host = config.networking.hostName;
      in
      {
        DHCP = "ipv6";
      }
      // secrets.hosts."${host}".network;
  };

  zenith.openlist.enable = true;
  zenith.transmission.enable = true;

}
