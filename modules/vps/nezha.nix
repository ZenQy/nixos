{
  config,
  lib,
  secrets,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.nezha;
in

{
  options = {
    zenith.nezha = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用nezha";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.nezha =
      let
        dir = "/var/lib/nezha";
        conf = (pkgs.formats.yaml { }).generate "config.yaml" {
          inherit (secrets.nezha) jwtsecretkey agentsecretkey listenport;
          debug = false;
          tls = false;
          language = "zh_CN";
          sitename = "Zenith的探针";
          usertemplate = "user-dist";
          admintemplate = "admin-dist";
          location = "Asia/Shanghai";
          install_host = "${secrets.nezha-agent.server}:${toString secrets.nezha.listenport}";
        };
      in
      {
        description = "Self-hosted, lightweight server and website monitoring and O&M tool";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        preStart =
          let
            file = "${dir}/data/config.yaml";
          in
          ''
            if [[ ! -e ${file} ]]
            then
              mkdir ${dir}/data
              cat ${conf} > ${file}
            fi
          '';
        serviceConfig = {
          User = "nixos";
          Group = "wheel";
          StateDirectory = "nezha";
          WorkingDirectory = dir;
          ExecStart = ''
            ${pkgs.nezha}/bin/nezha
          '';
          RestartSec = 5;
          Restart = "on-failure";
        };
      };
  };
}
