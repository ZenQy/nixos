{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "enp3s0";
    address = secrets.crunchbits.address;
    dns = [ "8.8.8.8" "2001:4860:4860::8888" ];
    routes = [
      { routeConfig.Gateway = secrets.crunchbits.gateway.ipv4; }
      {
        routeConfig = {
          Gateway = secrets.crunchbits.gateway.ipv6;
          GatewayOnLink = true;
        };
      }
    ];
  };

}
