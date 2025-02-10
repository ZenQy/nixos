{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "eth0";
    DHCP = "yes";
  };

  services.caddy = {
    enable = true;
    extraConfig =
      with builtins;
      let
        domain = tag: if tag == "claw" then "" else "${tag}.${secrets.domain}";
        config = concatStringsSep "\n" (
          concatMap (
            flag:
            map (
              tag: "reverse_proxy /${tag} ${domain tag}:${toString secrets.sing-box.trojan.port}"
            ) secrets.hosts.${flag}
          ) (attrNames secrets.hosts)
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
