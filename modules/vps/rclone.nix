{
  config,
  secrets,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.rclone;
in

{
  options = {
    zenith.rclone = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用rclone";
      };
      path = mkOption {
        default = [ ];
        example = [
          {
            source = "/home/nixos/.config";
            dest = "/osaka-arm";
            include = [ ];
            exclude = [ "mimeapps.list" ];
          }
        ];
        type =
          let
            pathOpts.options = {
              source = mkOption {
                type = types.str;
                description = "文件源路径";
              };
              dest = mkOption {
                type = types.str;
                description = "文件目标路径";
              };
              include = mkOption {
                default = [ ];
                type = types.listOf types.str;
                description = "包含符合指定模式的文件";
              };
              exclude = mkOption {
                default = [ ];
                type = types.listOf types.str;
                description = "排除符合指定模式的文件";
              };
            };
          in
          types.listOf (types.submodule pathOpts);
        description = "文件源位置和目标位置，已经相应的匹配规则。";
      };
    };
  };

  config = mkIf (cfg.enable && cfg.path != [ ]) {
    systemd.services.rclone =
      let
        ini = generators.toINI { } {
          webdav = {
            type = "webdav";
            vendor = "other";
            inherit (secrets.webdav) url user pass;
          };
        };
        conf = builtins.toFile "rclone.conf" ini;
        cmdList = map (
          x:
          let
            include = builtins.concatStringsSep " " (map (i: "--include ${i}") x.include);
            exclude = builtins.concatStringsSep " " (map (i: "--exclude ${i}") x.exclude);
          in
          "rclone --config ${conf} sync ${x.source} webdav:${x.dest} ${include} ${exclude}"
        ) cfg.path;
        cmd = builtins.concatStringsSep "\n" cmdList;
      in
      {
        description = "rclone";
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        path = [ pkgs.rclone ];
        script = ''
          ${cmd}
        '';
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          Group = "root";
          RuntimeDirectory = "rclone";
          CacheDirectory = "rclone";
          CacheDirectoryMode = "0700";
          PrivateTmp = true;
        };
      };
    systemd.timers.rclone = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
