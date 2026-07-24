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
      secrets.hosts."${host}".network;
  };

}
