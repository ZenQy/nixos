{
  source,
  linuxManualConfig,
  pkgs,
  ...
}:

with builtins;
let
  kernelVersion = concatStringsSep "." (
    match ".*?VERSION = ([[:xdigit:]]+).*?PATCHLEVEL = ([[:xdigit:]]+).*?SUBLEVEL = ([[:xdigit:]]+).*?" source.Makefile
  );
  kernelBranch = concatStringsSep "." (match "([[:xdigit:]]+)\.([[:xdigit:]]+).*?" kernelVersion);
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
