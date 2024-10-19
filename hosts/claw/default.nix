{ secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  systemd.network.networks.default = {
    name = "ens5";
    dns = [ "8.8.8.8" ];
    DHCP = "yes";
  };

  services.caddy = {
    enable = true;
    extraConfig =
      with builtins;
      let
        tagList = [
          "claw"
          "crbs"
          "osaka-1"
          "osaka-2"
          "tokyo-1"
          "tokyo-2"
          "natvps-ca"
          "natvps-jp"
        ];
        domain =
          tag:
          let
            tagNew = if substring 0 6 tag == "natvps" then tag + "-raw" else tag;
          in
          if tagNew == "claw" then "" else "${tagNew}.${secrets.domain}";
        config = concatStringsSep "\n" (
          map (
            tag: "reverse_proxy /${tag} ${domain tag}:${toString secrets.sing-box.trojan.port.${tag}}"
          ) tagList
        );
      in
      ''
        claw.${secrets.domain} {
          root * /nix/store
          file_server
          
          ${config}
        }
      '';
  };
}
