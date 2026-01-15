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
    networkConfig.DHCP = true;
  };

  zenith = {
    Ech0.enable = true;
    cachix.enable = true;
    nezha.enable = true;
    openlist.enable = true;
    rclone = {
      enable = true;
      path = [
        {
          source = "/var/lib/nezha/data/";
          dest = "/osaka-arm/nezha";
          exclude = [ "config.yaml" ];
        }
        {
          source = "/var/lib/vaultwarden/";
          dest = "/osaka-arm/vaultwarden";
          exclude = [ "tmp" ];
        }
      ];
    };
  };
  services = {
    sing-box.enable = false;

    caddy = {
      enable = true;
      extraConfig = ''
        q.${secrets.domain} {
        	reverse_proxy :6277
        }

        pan.${secrets.domain} {
        	reverse_proxy :5244
        }

        s.${secrets.domain} {
        	reverse_proxy :${toString secrets.nezha.listenport}
        }

        p.${secrets.domain} {
        	reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT}
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
        SIGNUPS_ALLOWED = true;
        WEB_VAULT_FOLDER = "${config.services.vaultwarden.webVaultPackage}/share/vaultwarden/vault";
        WEB_VAULT_ENABLED = true;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
      };
    };
  };

}
