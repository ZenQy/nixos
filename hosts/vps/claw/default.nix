{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    DHCP = true;
  };

  services.caddy = {
    enable = true;
    extraConfig =
      with builtins;
      let
        domain = tag: if tag == "claw" then "" else "${tag}.${secrets.domain}";
        config = concatStringsSep "\n" (
          map (
            tag: "reverse_proxy /${tag} ${domain tag}:${toString secrets.sing-box.trojan.port}"
          ) secrets.sing-box.server
        );
      in
      ''
        claw.${secrets.domain} {
          root * /var/lib/caddy/file
          file_server browse

          ${config}
        }
      '';
  };
}
