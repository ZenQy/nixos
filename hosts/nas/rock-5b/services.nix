{
  lib,
  pkgs,
  ...
}:

{
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

  systemd.services.alist =
    let
      path = "/var/lib/alist";
    in
    {
      description = "A file list/WebDAV program that supports multiple storages, powered by Gin and Solidjs.";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      preStart = ''
        if [[ ! -d "${path}/data" ]]
        then
          ${pkgs.alist}/bin/alist admin set admin
        fi
      '';
      serviceConfig = {
        User = "nixos";
        Group = "wheel";
        StateDirectory = "alist";
        RuntimeDirectory = "alist";
        WorkingDirectory = path;
        ExecStart = ''
          ${pkgs.alist}/bin/alist server
        '';
        RestartSec = 5;
        Restart = "on-failure";
      };
    };

  services.transmission = {
    enable = true;
    user = "nixos";
    group = "wheel";
    webHome = pkgs.flood-for-transmission;
    package = pkgs.transmission_4;
    settings = {
      dht-enabled = false;
      download-dir = "/storage/transmission";
      incomplete-dir-enabled = false;
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,10.0.0.*";
    };
  };

  services.caddy = {
    enable = true;
    extraConfig = ''
      http://10.0.0.12:6868 {
        root * ${pkgs.ariang}/share/ariang
        file_server browse
      }
      http://10.0.0.12:8686 {
        root * ${pkgs.chatgpt-web}/share/chatgpt-web
        file_server browse
      }
      http://10.0.0.12:8080 {
        root * /storage
        file_server browse
      }
      # 10.0.0.12 {
      #   reverse_proxy :5244
      # }
    '';
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      qd = {
        ports = [ "8923:80" ];
        volumes = [
          "qd_config:/usr/src/app/config"
        ];
        image = "qdtoday/qd";
        imageFile = pkgs.qd;
      };
    };
  };

}
