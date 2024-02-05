{ pkgs, secrets, ... }:
with builtins;

let lan = "enP4p1s0";
in

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];
  nixpkgs.hostPlatform.system = "aarch64-linux";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.network.networks.default = {
    name = lan;
    address = [ "10.0.0.8/24" ];
    gateway = [ "10.0.0.1" ];
    dns = [ "114.114.114.114" ];
    DHCP = "no";
  };

  services = {

    syncthing = {
      enable = true;
      user = "nixos";
      group = "wheel";
      guiAddress = "0.0.0.0:8384";
    };

  };
}
