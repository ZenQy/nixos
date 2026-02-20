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
      {
        inherit (secrets.hosts."${host}") Address Gateway;
        DHCP = "ipv6";
      };
  };

  zenith.openlist.enable = true;
  zenith.transmission.enable = true;

}
