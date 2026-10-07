{
  pkgs,
  secrets,
  ...
}:

{

  zenith = {
    Ech0.enable = true;
    cachix.enable = true;
    monitor.enable = true;
    rclone = {
      enable = true;
      path = [
        {
          source = "/var/lib/monitor";
          dest = "/osaka-arm/monitor";
        }
      ];
    };
  };
  services = {
    sing-box.enable = false;

    caddy = {
      enable = true;
      extraConfig = ''

        f.${secrets.domain} ${secrets.domain} {
          root * /var/lib/caddy/file
          file_server browse
        }

        e.${secrets.domain} {
        	reverse_proxy :6277
        }

        ${secrets.monitor.site} {
        	reverse_proxy :${secrets.monitor.port}
        }

        t.${secrets.domain} {
          root * ${pkgs.it-tools}/share/it-tools
          file_server browse
        }

      '';
    };

    # vaultwarden = {
    #   enable = true;
    #   config = {
    #     DOMAIN = "https://p.${secrets.domain}";
    #     SIGNUPS_ALLOWED = true;
    #     WEB_VAULT_FOLDER = "${config.services.vaultwarden.webVaultPackage}/share/vaultwarden/vault";
    #     WEB_VAULT_ENABLED = true;
    #     ROCKET_ADDRESS = "127.0.0.1";
    #     ROCKET_PORT = 8222;
    #   };
    # };
  };

  # environment.systemPackages = with pkgs; [
  #   wgcf
  # ];
}
