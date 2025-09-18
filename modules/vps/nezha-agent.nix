{
  config,
  lib,
  secrets,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.nezha-agent;
in

{
  options = {
    zenith.nezha-agent = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "是否启用nezha-agent";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.nezha-agent =
      let
        file = "/var/lib/nezha-agent/config.yaml";
        conf = (pkgs.formats.yaml { }).generate "config.yaml" {
          inherit (secrets.nezha-agent) client_secret;
          debug = false;
          disable_auto_update = true;
          disable_command_execute = true;
          disable_force_update = true;
          disable_nat = true;
          disable_send_query = false;
          gpu = false;
          insecure_tls = false;
          ip_report_period = 1800;
          report_delay = 3;
          self_update_period = 0;
          server = "${secrets.nezha-agent.server}:${toString secrets.nezha.listenport}";
          skip_connection_count = false;
          skip_procs_count = false;
          temperature = true;
          tls = false;
          use_gitee_to_upgrade = false;
          use_ipv6_country_code = false;
          uuid = secrets.nezha-agent.uuid.${config.networking.hostName};
        };
      in
      {
        description = "Agent of Nezha Monitoring";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        preStart = ''
          cat ${conf} > ${file}
        '';
        serviceConfig = {
          StateDirectory = "nezha-agent";
          ExecStart = ''
            ${pkgs.nezha-agent}/bin/nezha-agent -c ${file}
          '';
          RestartSec = 5;
          Restart = "on-failure";
        };
      };
  };
}
