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
    qd.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用qd";
    };
    traffmonetizer.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用traffmonetizer";
    };
    redroid.enable = mkOption {
      type = types.bool;
      default = false;
      description = "是否启用redroid";
    };
  };

  config = mkMerge [
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
    (mkIf cfg.redroid.enable {
      virtualisation.oci-containers.containers = {
        redroid = {
          autoStart = true;
          privileged = true;
          image = "cnflysky/redroid-rk3588:lineage-20";
          ports = [ "5555:5555" ];
          volumes = [ "redroid:/data" ];
          cmd = [
            "androidboot.redroid_height=1920"
            "androidboot.redroid_width=1080"
          ];
        };
      };
    })
  ];
}
