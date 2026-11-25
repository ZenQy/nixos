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

  zenith = {
    aria2.enable = true;
    freellmapi.enable = true;
    openlist.enable = true;
    transmission.enable = true;
  };
}
