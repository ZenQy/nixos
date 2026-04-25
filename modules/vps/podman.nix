{
  config,
  pkgs,
  secrets,
  lib,
  ...
}:
with lib;

let
  cfg = config.zenith.podman;
in

{
  options.zenith.podman = {
    metapi.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用metapi";
    };
    qd.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用qd";
    };
    qinglong.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用青龙";
    };
    traffmonetizer.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用traffmonetizer";
    };
  };

  config = mkMerge [
    (mkIf cfg.metapi.enable {
      virtualisation.oci-containers.containers = {
        metapi = {
          autoStart = true;
          image = "1467078763/metapi:latest";
          ports = [ "4000:4000" ];
          volumes = [ "metapi:/app/data" ];
          environment = {
            AUTH_TOKEN = secrets.user.password.zenith;
            PROXY_TOKEN = secrets.user.password.root;
            TZ = "Asia/Shanghai";
          };
        };
      };
    })
    (mkIf cfg.qd.enable {
      virtualisation.oci-containers.containers = {
        qd = {
          autoStart = true;
          image = "qdtoday/qd:lite-latest";
          ports = [ "8923:80" ];
          volumes = [ "qd:/usr/src/app/config" ];
        };
      };
    })
    (mkIf cfg.qinglong.enable {
      virtualisation.oci-containers.containers = {
        qinglong = {
          autoStart = true;
          image = "whyour/qinglong:latest";
          ports = [ "5700:5700" ];
          volumes = [ "qinglong:/ql/data" ];
        };
      };
    })
    (mkIf cfg.traffmonetizer.enable {
      virtualisation.oci-containers.containers = {
        traffmonetizer = {
          autoStart = true;
          image =
            let
              tag = if pkgs.stdenv.hostPlatform.isx86_64 then "latest" else "arm64v8";
            in
            "traffmonetizer/cli_v2:" + tag;
          cmd = [
            "start"
            "accept"
            "--token"
            secrets.traffmonetizer.token
            "--device-name"
            config.networking.hostName
          ];
        };
      };
    })
  ];
}
