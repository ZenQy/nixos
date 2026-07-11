{ config, secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    networkConfig =
      let
        host = config.networking.hostName;
      in
    secrets.hosts."${host}";
  };

}
