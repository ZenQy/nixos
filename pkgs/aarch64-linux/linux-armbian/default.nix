{
  source,
  linuxManualConfig,
  pkgs,
  ...
}:

linuxManualConfig {
  inherit (source) src;

  extraMeta.branch = "6.1";
  version = "6.1.75-armbian";
  modDirVersion = "6.1.75";

  configfile = ./config;
  allowImportFromDerivation = true;

  kernelPatches = with pkgs.kernelPatches; [
    bridge_stp_helper
    request_key_helper
  ];

}
