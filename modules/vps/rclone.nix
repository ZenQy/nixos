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
        type = types.listOf (
          types.submodule {
            options = {
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
          }
        );
        description = "文件源位置和目标位置，以及相应的匹配规则";
      };
    };
  };

  config = mkIf (cfg.enable && cfg.path != [ ]) {
    systemd.services.rclone =
      let
        rcloneConfig = generators.toINI { } {
          webdav = {
            type = "webdav";
            vendor = "other";
            inherit (secrets.webdav) url user pass;
          };
        };
        configFile = builtins.toFile "rclone.conf" rcloneConfig;

        # 构建rclone命令列表
        makeRcloneCmd =
          path:
          let
            includeArgs = concatMapStringsSep " " (i: "--include ${i}") path.include;
            excludeArgs = concatMapStringsSep " " (i: "--exclude ${i}") path.exclude;
          in
          "rclone --config ${configFile} sync ${path.source} webdav:${path.dest} ${includeArgs} ${excludeArgs}";

        syncCommands = concatMapStringsSep "\n" makeRcloneCmd cfg.path;
      in
      {
        description = "Rclone WebDAV Sync";
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        path = [ pkgs.rclone ];
        script = ''
          ${syncCommands}
        '';
        serviceConfig = {
          Type = "oneshot";
          User = "root";
          Group = "root";
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
