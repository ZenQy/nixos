{
  source,
  linuxManualConfig,
  pkgs,
  ...
}:

let
  inherit (builtins) readFile concatStringsSep match;
  makefile = readFile source.extract.Makefile;
  kernelVersion = concatStringsSep "." (
    match ".*?VERSION = ([[:xdigit:]]+).*?PATCHLEVEL = ([[:xdigit:]]+).*?SUBLEVEL = ([[:xdigit:]]+).*?" makefile
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
