{
  source,
  linuxManualConfig,
  pkgs,
  ...
}:

let
  kernelBranch = "6.1";
  kernelVersion = "6.1.75";
in
linuxManualConfig {
  inherit (source) src;

  extraMeta.branch = kernelBranch;
  version = "${kernelVersion}-armbian";
  modDirVersion = kernelVersion;

  configfile = ./config;
  allowImportFromDerivation = true;

  kernelPatches = with pkgs.kernelPatches; [
    bridge_stp_helper
    request_key_helper
  ];
}
