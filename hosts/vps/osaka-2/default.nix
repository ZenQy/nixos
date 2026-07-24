{
  pkgs,
  ...
}:

{
  imports = [
    ./services.nix
    ./hardware.nix
  ];

  systemd.network.networks.eth0 = {
    name = "eth0";
    networkConfig.DHCP = true;
  };

  environment.systemPackages = with pkgs; [
    nvfetcher
  ];
}
