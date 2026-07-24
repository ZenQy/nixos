{ config, secrets, ... }:

{
  imports = [
    ./services.nix
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

}
