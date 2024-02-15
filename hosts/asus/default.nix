{ pkgs, secrets, ... }:

{
  imports = [
    ./hardware.nix
  ];

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  systemd.network.networks.default = {
    name = "enp3s0";
    address = [ "10.0.0.6/24" ];
    gateway = [ "10.0.0.5" ];
    dns = [ "119.29.29.29" "223.5.5.5" ];
    DHCP = "no";
  };

  services.jellyfin = {
    enable = true;
    user = "nixos";
    group = "wheel";
  };
  systemd.services.hysteria.enable = false;

  systemd.services.qbittorrent = {
    description = "Featureful free software BitTorrent client";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "nixos";
      Group = "wheel";
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
      RestartSec = 5;
      Restart = "on-failure";
    };
  };
  services.transmission = {
    enable = true;
    user = "nixos";
    group = "wheel";
    settings = {
      dht-enabled = false;
      download-dir = "/storage";
      incomplete-dir-enabled = false;
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,10.0.0.*";
    };
  };

}
