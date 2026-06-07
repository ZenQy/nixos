{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.zenith.freellmapi;
in

{
  options = {
    zenith.freellmapi = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用freellmapi";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.freellmapi = {
      description = "One OpenAI-compatible endpoint. Sixteen free LLM providers. ~1.7B tokens per month.";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        StateDirectory = "freellmapi";
        WorkingDirectory = "/var/lib/freellmapi";
        ExecStart = ''
          ${pkgs.nodejs}/bin/node ${pkgs.freellmapi}/server/dist/index.js
        '';
        RestartSec = 5;
        Restart = "on-failure";
      };
    };
  };
}
