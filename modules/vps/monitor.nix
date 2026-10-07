{
  config,
  lib,
  secrets,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.monitor;
in

{
  options = {
    zenith.monitor = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用monitor";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.monitor = {
      description = "用 Rust 写的轻量级服务器探针 (Rust + axum + SQLite)";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        User = "nixos";
        Group = "wheel";
        StateDirectory = "monitor";
        WorkingDirectory = "/var/lib/monitor";
        NoNewPrivileges = "yes";
        RestrictSUIDSGID = "yes";
        ProtectSystem = "strict";
        ProtectHome = "yes";
        PrivateTmp = "yes";
        PrivateDevices = "yes";
        MemoryMax = "256M";
        ExecStart = ''
          ${pkgs.monitor}/bin/monitor-hub \
            --listen 127.0.0.1:${secrets.monitor.port} \
            --site https://${secrets.monitor.site}
        '';
        RestartSec = 5;
        Restart = "on-failure";
      };
    };
  };
}
