{
  config,
  lib,
  secrets,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.komari;
in

{
  options = {
    zenith.komari = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用komari";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.komari = {
      description = "A simple server monitor tool.";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        User = "nixos";
        Group = "wheel";
        StateDirectory = "komari";
        WorkingDirectory = "/var/lib/komari";
        ExecStart = ''
          ${pkgs.komari}/bin/komari server -l localhost:${secrets.komari.port}
        '';
        RestartSec = 5;
        Restart = "on-failure";
      };
    };
  };
}
