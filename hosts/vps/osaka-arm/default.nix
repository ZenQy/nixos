{
  config,
  pkgs,
  secrets,
  ...
}:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    DHCP = "yes";
  };
  zenith = {
    cachix.enable = true;
    nezha.enable = true;
    rclone = {
      enable = true;
      path = [
        {
          source = "/var/lib/nezha/data/";
          dest = "/osaka-arm/nezha";
          exclude = [ "config.yaml" ];
        }
      ];
    };
  };
  services = {
    sing-box.enable = false;

    code-server = {
      enable = true;
      disableTelemetry = true;
      disableUpdateCheck = true;
      disableWorkspaceTrust = true;
      user = "nixos";
      group = "wheel";
      host = "127.0.0.1";
      extraPackages = with pkgs; [
        nixfmt-rfc-style
        nixd

        go
        gopls

        rustc
        rustfmt
        cargo
        rust-analyzer

        gcc
        leetgo
      ];
    };

    caddy = {
      enable = true;
      extraConfig = ''
        s.${secrets.domain} {
        	reverse_proxy :${toString secrets.nezha.listenport}
        }

        p.${secrets.domain} {
        	reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT}
        }

        x.${secrets.domain} {
        	reverse_proxy :${toString config.services.code-server.port}
        }

        t.${secrets.domain} {
          root * ${pkgs.it-tools}/share/it-tools
          file_server browse
        }

        f.${secrets.domain} {
          root * /var/lib/caddy/file
          file_server browse
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

}
