{
  config,
  lib,
  secrets,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.zenith.librespeed-rs;
in

{
  options = {
    zenith.librespeed-rs = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "是否启用librespeed-rs";
      };
      address = mkOption {
        type = types.str;
        default = "::";
        description = "bind socket adress";
      };
      port = mkOption {
        type = types.int;
        default = 2080;
        description = "socket listent port";
      };
      threads = mkOption {
        type = types.int;
        default = 1;
        description = "you can specify the number of worker threads";
      };
      ipinfo = mkOption {
        type = types.str;
        default = secrets.ipinfo.token;
        description = "ipinfo.io API key";
      };
      password = mkOption {
        type = types.str;
        default = secrets.user.password.root;
        description = "password for logging into statistics page, fill this to enable stats page";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.librespeed-rs =
      let
        path = "/var/lib/librespeed-rs";
        conf = (pkgs.formats.toml { }).generate "config.toml" {
          bind_address = cfg.address;
          listen_port = cfg.port;
          worker_threads = cfg.threads;
          base_url = "backend";
          ipinfo_api_key = cfg.ipinfo;
          assets_path = "";
          stats_password = cfg.password;
          redact_ip_addresses = false;
          result_image_theme = "light";
          database_type = "sqlite";
          database_hostname = config.networking.hostName;
          database_name = "speedtest_db";
          database_username = "";
          database_password = "";
          database_file = "speedtest.db";
          enable_tls = false;
          tls_cert_file = "";
          tls_key_file = "";
        };
      in
      {
        description = "Rust backend for LibreSpeed";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          StateDirectory = "librespeed-rs";
          RuntimeDirectory = "librespeed-rs";
          WorkingDirectory = path;
          ExecStart = ''
            ${pkgs.librespeed-rs}/bin/librespeed-rs -c ${conf}
          '';
          RestartSec = 5;
          Restart = "on-failure";
        };
      };
  };
}
