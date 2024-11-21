{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [
      "104.36.86.45/22"
      "2606:a8c0:3:148::a/64"
    ];
    routes = [
      { Gateway = "104.36.84.1"; }
      {
        Gateway = "2606:a8c0:3::1";
        GatewayOnLink = true;
      }
    ];
  };

  zenith.cachix.enable = true;
  environment.systemPackages = with pkgs; [
    nvfetcher
  ];
}
