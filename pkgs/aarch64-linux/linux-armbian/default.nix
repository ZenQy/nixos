{
  source,
  linuxManualConfig,
  ...
}:

linuxManualConfig {
  version = "6.1.75-armbian";
  modDirVersion = "6.1.75";
  extraMeta.branch = "6.1";

  src = source.src;

  configfile = ./config;
}
