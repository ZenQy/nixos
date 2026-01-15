{ secrets, ... }:

{
  imports = [
    ./services.nix
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    networkConfig = {
      Address = secrets.hosts.rock-5b.ipv4.ip;
      Gateway = secrets.hosts.rock-5b.ipv4.gateway;
      DHCP = "ipv6";
    };
  };

}
