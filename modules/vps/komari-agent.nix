{
  config,
  lib,
  secrets,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.komari-agent;
in

{
  options = {
    zenith.komari-agent = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "是否启用komari-agent";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.komari-agent =
      let
        dir = "/var/lib/komari-agent";
        conf = {
          auto_discovery_key = secrets.komari.auto_discovery_key; # 自动发现密钥
          disable_auto_update = true; # 禁用自动更新
          disable_web_ssh = false; # 禁用远程控制（web ssh 和 rce）
          endpoint = "https://${secrets.komari.server}:${secrets.komari.port}"; # 面板地址
          ignore_unsafe_cert = false; # 忽略不安全的证书
          month_rotate = 1; # 流量统计的月份重置日期（0表示禁用）
          get_ip_addr_from_nic = false; # 从网卡获取IP地址
          config_file = "${dir}/config.json"; # JSON配置文件路径
        };
      in
      {
        description = "Lightweight server probe for simple, efficient monitoring";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        preStart = ''
          cat ${builtins.toJSON conf} > ${conf.config_file}
        '';
        serviceConfig = {
          StateDirectory = "komari-agent";
          WorkingDirectory = dir;
          ExecStart = ''
            ${pkgs.komari-agent}/bin/komari-agent --config ${conf.config_file}
          '';
          RestartSec = 5;
          Restart = "on-failure";
        };
      };
  };
}
