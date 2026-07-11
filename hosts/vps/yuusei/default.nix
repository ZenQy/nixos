{ config, secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default =
    let
      host = config.networking.hostName;
    in
    {
      name = "eth0";
    }
    // secrets.hosts."${host}";
}
