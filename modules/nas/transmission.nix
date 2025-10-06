{ lib, pkgs, ... }:

with lib;

let
  cfg = config.zenith.transmission;
in

{
  options = {
    zenith.transmission = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用transmission";
      };
    };
  };

  config = mkIf cfg.enable {
    services.transmission = {
      enable = false;
      user = "nixos";
      group = "wheel";
      webHome = pkgs.flood-for-transmission;
      package = pkgs.transmission_4;
      settings = {
        dht-enabled = false;
        download-dir = "/storage/transmission";
        incomplete-dir-enabled = false;
        rpc-bind-address = "0.0.0.0";
        rpc-whitelist = "127.0.0.1,10.0.0.*";
      };
    };
  };
}
