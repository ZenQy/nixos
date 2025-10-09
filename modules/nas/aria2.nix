{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.zenith.aria2;
in

{
  options = {
    zenith.aria2 = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用aria2";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.aria2 =
      let
        path = "/var/lib/aria2";
        settings = {
          # 配置参考https://github.com/P3TERX/aria2.conf/blob/master/aria2.conf
          dir = "/storage/aria2";
          disk-cache = "64M";
          file-allocation = "none"; # 建议：机械硬盘falloc；固态硬盘none
          no-file-allocation-limit = "64M";
          continue = true;
          always-resume = false;
          max-resume-failure-tries = 0;
          remote-time = true;
          input-file = "aria2.session";
          save-session = "aria2.session";
          save-session-interval = 1;
          http-accept-gzip = true;
          content-disposition-default-utf8 = true;
          enable-rpc = true;
          rpc-listen-all = true;
          rpc-allow-origin-all = true;
          rpc-secure = false;
          check-certificate = false;
        };
        conf = builtins.toFile "aria2.conf" (lib.generators.toKeyValue { } settings);
      in
      {
        description = "aria2 Service";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        preStart = ''
          if [[ ! -e "${path}/${settings.save-session}" ]]
          then
            touch "${path}/${settings.save-session}"
          fi
        '';
        serviceConfig = {
          User = "nixos";
          Group = "wheel";
          StateDirectory = "aria2";
          RuntimeDirectory = "aria2";
          WorkingDirectory = path;
          ExecStart = ''
            ${pkgs.aria2}/bin/aria2c --conf-path=${conf}
          '';
          ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
          Restart = "on-abort";
        };
      };
  };
}
