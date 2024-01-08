{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  nix.settings.substituters = [
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  systemd.network.networks.default = {
    name = "enp3s0";
    address = [ "10.0.0.10/24" ];
    gateway = [ "10.0.0.11" ];
    dns = [ "119.29.29.29" "223.5.5.5" ];
    DHCP = "no";
  };
}
