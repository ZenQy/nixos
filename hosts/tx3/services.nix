{ pkgs, ... }:

{
  # services.navidrome = {
  #   enable = true;
  #   settings = {
  #     Address = "0.0.0.0";
  #     Port = 4533;
  #     ScanSchedule = "@daily";
  #     MusicFolder = "/storage/music";
  #     DefaultLanguage = "zh-Hans";
  #   };
  # };
  # systemd.services.navidrome.serviceConfig = with lib;{
  #   User = mkForce "nixos";
  #   Group = mkForce "wheel";
  # };
  services.aria2 = {
    enable = true;
    settings = {
      dir = "/storage/aria2";
    };
    rpcSecretFile = builtins.toFile "aria2.txt" "";
  };

  systemd.services.alist = {
    description = "A file list/WebDAV program that supports multiple storages, powered by Gin and Solidjs.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    preStart = ''
      if [[ ! -d "/var/lib/alist/data" ]]
      then
        ${pkgs.alist}/bin/alist admin set admin
      fi
    '';
    serviceConfig = {
      User = "nixos";
      Group = "wheel";
      StateDirectory = "alist";
      RuntimeDirectory = "alist";
      WorkingDirectory = "/var/lib/alist";
      ExecStart = ''
        ${pkgs.alist}/bin/alist server
      '';
      RestartSec = 5;
      Restart = "on-failure";
    };
  };

  services.cron.systemCronJobs = [
    "0 2 * * *  nixos  ${pkgs.curl}/bin/curl https://raw.githubusercontent.com/fanmingming/live/main/tv/m3u/ipv6.m3u -o /storage/ipv6.m3u"
  ];

  services.caddy = {
    enable = true;
    extraConfig = ''
      http://10.0.0.11:6868 {
        root * ${pkgs.ariang}/share/ariang
        file_server browse
      }
      http://10.0.0.11:8080 {
        root * /storage
        file_server browse
      }
      10.0.0.11 {
        reverse_proxy :5244
      }
    '';
  };
}
