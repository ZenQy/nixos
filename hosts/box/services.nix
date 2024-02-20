{ lib, pkgs, ... }:

{
  services.navidrome = {
    enable = true;
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      ScanSchedule = "@daily";
      MusicFolder = "/storage/music";
      DefaultLanguage = "zh-Hans";
    };
  };
  systemd.services.navidrome.serviceConfig = with lib;{
    # DynamicUser = mkForce false;
    User = mkForce "nixos";
    Group = mkForce "wheel";
  };

  systemd.services.aria2 = {
    description = "aria2 Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    preStart =
      let
        path = "/var/lib/aria2";
        settings = {
          # 配置参考https://github.com/P3TERX/aria2.conf/blob/master/aria2.conf
          dir = "/storage/aria2";
          disk-cache = "64M";
          file-allocation = "falloc"; # 建议：机械硬盘falloc；固态硬盘none
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
          check-certificate = false;
        };
        conf = lib.generators.toKeyValue { } settings;
      in
      ''
        if [[ ! -e "${path}/${settings.save-session}" ]]
        then
          touch "${path}/${settings.save-session}"
        fi
        echo "${conf}" > aria2.conf
      '';
    serviceConfig = {
      User = "nixos";
      Group = "wheel";
      StateDirectory = "aria2";
      RuntimeDirectory = "aria2";
      WorkingDirectory = "/var/lib/aria2";
      ExecStart = ''
        ${pkgs.aria2}/bin/aria2c --conf-path=/var/lib/aria2/aria2.conf
      '';
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-abort";
    };
  };

  systemd.services.alist = {
    description = "A file list/WebDAV program that supports multiple storages, powered by Gin and Solidjs.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    preStart = ''
      if [[ ! -d "/var/lib/alist/data" ]]
      then
        ${pkgs.alist}/bin/alist admin set admin
      fi
    '';
    serviceConfig = {
      User = "nixos";
      Group = "wheel";
      StateDirectory = "alist";
      RuntimeDirectory = "alist";
      WorkingDirectory = "/var/lib/alist";
      ExecStart = ''
        ${pkgs.alist}/bin/alist server
      '';
      RestartSec = 5;
      Restart = "on-failure";
    };
  };
}
