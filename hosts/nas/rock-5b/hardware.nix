# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform.system = "aarch64-linux";
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "sd_mod"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/ROOTFS";
    fsType = "btrfs";
    options = [
      "compress-force=zstd"
      "nosuid"
      "nodev"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/EFI";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };

  swapDevices = [ ];
  boot.loader = {
    efi.canTouchEfiVariables = false;
    systemd-boot = {
      configurationLimit = 1;
      consoleMode = "auto";
      enable = true;
    };
    timeout = 1;
  };
}