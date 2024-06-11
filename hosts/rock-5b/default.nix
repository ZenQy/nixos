{ ... }:

{
  imports = [
    ./hardware.nix
    ../tx3/sing-box.nix
  ];
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  systemd.network.networks.default = {
    name = "enP4p1s0";
    address = [ "10.0.0.8/24" ];
    gateway = [ "10.0.0.1" ];
    dns = [ "114.114.114.114" ];
    DHCP = "ipv6";
  };

}
