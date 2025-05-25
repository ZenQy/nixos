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
    qinglong.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用qinglong";
    };
    traffmonetizer.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用traffmonetizer";
    };
    qd.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用qd";
    };
  };

  config = mkMerge [
    (mkIf cfg.qinglong.enable {
      virtualisation.oci-containers.containers = {
        qinglong = {
          autoStart = true;
          image = "whyour/qinglong:latest";
          ports = [ "2011:5700" ];
          volumes = [ "qinglong:/ql/data" ];
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
