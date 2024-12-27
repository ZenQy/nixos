{
  config,
  lib,
  secrets,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.nezha-dashboard;
in

{
  options = {
    zenith.nezha-dashboard = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用nezha-dashboard";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.nezha-dashboard =
      let
        path = "/var/lib/nezha-dashboard";
        conf = (pkgs.formats.yaml { }).generate "config.yaml" {
          inherit (secrets.nezha-dashboard) jwtsecretkey agentsecretkey listenport;
          debug = false;
          tls = false;
          language = "zh_CN";
          sitename = "Zenith的探针";
          usertemplate = "user-dist";
          admintemplate = "admin-dist";
          location = "Asia/Shanghai";
        };
      in
      {
        description = "Self-hosted, lightweight server and website monitoring and O&M tool";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        preStart =
          let
            file = "${path}/data/config.yaml";
          in
          ''
            if [[ ! -e ${file} ]]
            then
              mkdir ${path}/data
              cat ${conf} > ${file}
            fi
          '';
        serviceConfig = {
          User = "nixos";
          Group = "wheel";
          StateDirectory = "nezha-dashboard";
          RuntimeDirectory = "nezha-dashboard";
          WorkingDirectory = path;
          ExecStart = ''
            ${pkgs.nezha-dashboard}/bin/nezha-dashboard
          '';
          RestartSec = 5;
          Restart = "on-failure";
        };
      };
  };
}
