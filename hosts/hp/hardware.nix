# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/f5ff955f-29a1-4a94-a8b9-cff0bfc2a691";
      fsType = "ext4";
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/310ed9f0-4a53-47c9-b75f-31c202590b10";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/0E98-4610";
      fsType = "vfat";
    };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = false;
    systemd-boot = {
      configurationLimit = 1;
      consoleMode = "auto";
      enable = true;
    };
    timeout = 5;
  };
}
