{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware.nix
  ];

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  systemd.network.networks.default = {
    name = "end0";
    address = [ "10.0.0.9/24" ];
    gateway = [ "10.0.0.1" ];
    dns = [ "114.114.114.114" ];
    DHCP = "no";
  };

  services.nezha-agent.enable = false;

}

# LABEL   Armbian
# LINUX /zImage
# INITRD /uInitrd
# FDT /dtb/amlogic/meson-gxl-s905d-phicomm-n1.dtb
# APPEND root=UUID=ebb01a2b-d47b-43f7-aa46-0a125a8f1d61 rootflags=compress-force=zstd rootfstype=btrfs console=ttyAML0,115200n8 console=tty0 consoleblank=0
