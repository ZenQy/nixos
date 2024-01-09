{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware.nix
  ];


  hardware.deviceTree = {
    enable = true;
    name = "meson-gxl-s905d-phicomm-n1.dtb";
    filter = "*s905*.dtb";
  };

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.hostPlatform.system = "aarch64-linux";

  systemd.network.networks.default = {
    name = "eth0";
    address = [ "10.0.0.9/24" ];
    gateway = [ "10.0.0.1" ];
    dns = [ "114.114.114.114" ];
    DHCP = "no";
  };
}

# label Armbian
#     kernel /zImage
#     initrd /uInitrd
#     fdt /dtb/amlogic/meson-gxl-s905d-phicomm-n1.dtb
#     append root=UUID=a8fe2919-0be3-4470-998d-0df2ae4d93cf rootflags=data=writeback rw rootfstype=ext4 no_console_suspend consoleblank=0 fsck.fix=yes fsck.repair=yes net.ifnames=0 max_loop=128 loglevel=1 voutmode=hdmi disablehpd=false overscan=100 sdrmode=auto

# console=ttyAML0,115200n8 console=tty0 loglevel=1
