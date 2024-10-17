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
    extraConfig = ''
      claw.${secrets.domain} {
        root * /nix/store
        file_server

        reverse_proxy /claw 127.0.0.1:${toString secrets.sing-box.trojan.port.claw}
        reverse_proxy /tokyo-1 tokyo-1.${toString secrets.sing-box.trojan.port.tokyo-1}
        reverse_proxy /natvps-jp natvps-jp.${toString secrets.sing-box.trojan.port.natvps-jp}
      }
    '';
  };
}
