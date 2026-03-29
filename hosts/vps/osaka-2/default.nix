{
  pkgs,
  ...
}:

{
  imports = [
    ./services.nix
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    networkConfig.DHCP = true;
  };

  environment.systemPackages = with pkgs; [
    nvfetcher
  ];
}
