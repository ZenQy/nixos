{ secrets, pkgs, ... }:

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
        tagList = attrNames secrets.sing-box.trojan.port;
        short = tag: substring 9 (stringLength tag) tag;
        domain = tag: if tag == "claw" then "" else "${tag}.${secrets.domain}";
        config = concatStringsSep "\n" (
          map (
            tag:
            "reverse_proxy /${short tag} ${domain (short tag)}:${toString secrets.sing-box.trojan.port.${tag}}"
          ) tagList
        );
      in
      ''
        claw.${secrets.domain} {
          root * ${pkgs.caddy}/share
          file_server browse
          
          ${config}
        }
      '';
  };
}
