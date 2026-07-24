{ config, secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.eth0 =
    let
      host = config.networking.hostName;
    in
    {
      name = "eth0";
    }
    // secrets.hosts."${host}".network;
}
