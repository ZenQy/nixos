{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.Ech0;
in

{
  options = {
    zenith.Ech0 = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用Ech0";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.Ech0 = {
      description = "Ech0 - 开源、自托管、专注思想流动的轻量级发布平台";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        StateDirectory = "Ech0";
        WorkingDirectory = "/var/lib/Ech0";
        ExecStart = ''
          ${pkgs.Ech0}/bin/ech0 serve
        '';
        RestartSec = 5;
        Restart = "on-failure";
      };
    };
  };
}
