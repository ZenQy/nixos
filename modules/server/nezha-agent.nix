{ config, lib, pkgs, secrets, ... }:
with lib;
let
  cfg = config.services.nezha-agent;
in

{
  options.services.nezha-agent = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "是否启用nezha-agent";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.nezha-agent = {
      description = "nezha-agent Daemon";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.nezha-agent ];
      script = ''
        exec nezha-agent \
        -s=${secrets.nezha-agent.server} \
        -p=${config.networking.hostName}${secrets.nezha-agent.password} \
        -d=false \
        --report-delay=3 \
        --skip-conn=true \
        --skip-procs=true \
        --disable-auto-update=true \
        --disable-force-update=true
      '';
    };
  };
}
