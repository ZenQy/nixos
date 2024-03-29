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
    cachix.enable = true;
    nezha-dashboard.enable = true;
    sing-box.enable = false;

    code-server = {
      enable = true;
      disableTelemetry = true;
      disableUpdateCheck = true;
      disableWorkspaceTrust = true;
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
        tz.${secrets.domain} {
        	reverse_proxy :${toString secrets.nezha-dashboard.httpport}
        }

        p.${secrets.domain} {
        	reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT}
        }

        code.${secrets.domain} {
        	reverse_proxy :${toString config.services.code-server.port}
        }
      '';
    };

    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://p.${secrets.domain}";
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
