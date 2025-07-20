{
  source,
  linuxManualConfig,
  pkgs,
  ...
}:

let
  kernelBranch = "6.12";
  kernelVersion = "6.12.39";
in
linuxManualConfig {
  inherit (source) src;

  extraMeta.branch = kernelBranch;
  version = "${kernelVersion}-flippy";
  modDirVersion = kernelVersion;

  configfile = ./config;
  allowImportFromDerivation = true;

  kernelPatches = with pkgs.kernelPatches; [
    bridge_stp_helper
    request_key_helper
  ];
}
