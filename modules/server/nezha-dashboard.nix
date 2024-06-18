{ config, lib, pkgs, secrets, ... }:
with lib;

let
  cfg = config.zenith.nezha-dashboard;
in

{
  options.zenith.nezha-dashboard = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用nezha-dashboard";
    };
  };

  config = mkIf cfg.enable {
    environment.etc."nezha/dashboard.yaml".text = ''
      debug: false
      site:
        brand: 小鸡探针-哪吒面板
        cookiename: nezha-dashboard
        theme: default
        customcode: ""
        viewpassword: ""
      oauth2:
        type: github
        admin: ZenQy
        clientid: ${secrets.nezha-dashboard.clientid}
        clientsecret: ${secrets.nezha-dashboard.clientsecret}
      httpport: ${toString secrets.nezha-dashboard.httpport}
      grpcport: ${toString secrets.nezha-dashboard.grpcport}
      enableipchangenotification: false
    '';

    systemd.services.nezha-dashboard = {
      description = "nezha-dashboard Daemon";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.nezha-dashboard ];
      script = ''
        exec nezha-dashboard
      '';
    };
  };
}
