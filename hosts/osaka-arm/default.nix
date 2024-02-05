{ config, pkgs, secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "enp0s3";
    dns = [ "8.8.8.8" ];
    DHCP = "yes";
  };

  services = {
    nezha-dashboard.enable = true;
    sing-box.enable = false;

    code-server = {
      enable = true;
      disableTelemetry = true;
      disableUpdateCheck = true;
      disableWorkspaceTrust = true;
      extraArguments = map (x: "--install-extension ${x}") [
        "mhutchie.git-graph"
        "golang.go"
        "pkief.material-icon-theme"
        "jnoortheen.nix-ide"
        "rust-lang.rust-analyzer"
        "tamasfe.even-better-toml"
        "usernamehw.errorlens"
      ];
      user = "nixos";
      group = "wheel";
      host = "127.0.0.1";
      extraPackages = with pkgs;[
        nil
        nixpkgs-fmt

        go
        gopls
        dlv-dap
        staticcheck

        cargo
        rustc
        rustfmt

        gcc
        leetgo
      ];
    };

    caddy = {
      enable = true;
      extraConfig = ''
        tz.${secrets.ssl.domain} {
        	reverse_proxy :${toString secrets.nezha-dashboard.httpport}
        }

        p.${secrets.ssl.domain} {
        	reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT}
        }

        code.${secrets.ssl.domain} {
        	reverse_proxy :${toString config.services.openvscode-server.port}
        }
      '';
    };

    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://p.${secrets.ssl.domain}";
        SIGNUPS_ALLOWED = false;
        WEB_VAULT_FOLDER = "${config.services.vaultwarden.webVaultPackage}/share/vaultwarden/vault";
        WEB_VAULT_ENABLED = true;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    nvfetcher
    wget
  ];

  environment.variables = {
    LEETCODE_SESSION = secrets.leetcode.SESSION;
    LEETCODE_CSRFTOKEN = secrets.leetcode.CSRFTOKEN;
  };

}
