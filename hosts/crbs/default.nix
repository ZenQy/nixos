{ pkgs, secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "enp3s0";
    address = secrets.crunchbits.address;
    routes = [
      { Gateway = secrets.crunchbits.gateway.ipv4; }
      {
        Gateway = secrets.crunchbits.gateway.ipv6;
        GatewayOnLink = true;
      }
    ];
  };

  zenith.cachix.enable = true;
  environment.systemPackages = with pkgs; [
    nvfetcher
  ];
}
