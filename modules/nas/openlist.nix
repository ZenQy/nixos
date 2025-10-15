{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.zenith.openlist;
in

{
  options = {
    zenith.openlist = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用openlist";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.openlist =
      let
        path = "/var/lib/openlist";
      in
      {
        description = "A file list/WebDAV program that supports multiple storages, powered by Gin and Solidjs.";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        preStart = ''
          if [[ ! -d "${path}/data" ]]
          then
            ${pkgs.openlist}/bin/OpenList admin set admin
          fi
        '';
        serviceConfig = {
          User = "nixos";
          Group = "wheel";
          StateDirectory = "openlist";
          WorkingDirectory = path;
          ExecStart = ''
            ${pkgs.openlist}/bin/OpenList server
          '';
          RestartSec = 5;
          Restart = "on-failure";
        };
      };
  };

}
