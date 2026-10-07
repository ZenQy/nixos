{
  config,
  lib,
  secrets,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.monitor-agent;
in

{
  options = {
    zenith.monitor-agent = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "是否启用monitor-agent";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.monitor-agent = {
      description = "Lightweight server probe for simple, efficient monitoring";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        StateDirectory = "monitor-agent";
        WorkingDirectory = "/var/lib/monitor-agent";
        ExecStart = ''
          ${pkgs.monitor-agent}/bin/monitor-agent --server https://${secrets.monitor.site} --token ${
            secrets.monitor.token.${config.networking.hostName}
          }
        '';
        RestartSec = 5;
        Restart = "on-failure";
      };
    };
  };
}
