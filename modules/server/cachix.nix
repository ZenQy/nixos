{ config, lib, pkgs, secrets, ... }:

with lib;

let
  cfg = config.services.cachix;
in

{
  options = {
    services.cachix = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用cachix";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.variables.CACHIX_AUTH_TOKEN = secrets.cachix.token;
    environment.systemPackages = with pkgs; [
      cachix
    ];
  };
}
