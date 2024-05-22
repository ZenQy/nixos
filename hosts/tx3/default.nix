{ ... }:

{
  imports = [
    ./hardware.nix
    ./sing-box.nix
    ./services.nix
  ];

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  systemd.network.networks.default = {
    name = "eth0";
    address = [ "10.0.0.11/24" ];
    gateway = [ "10.0.0.1" ];
    dns = [ "114.114.114.114" ];
    DHCP = "no";
  };

}
