{ pkgs, ... }:

{
  services = {

    navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        ScanSchedule = "@daily";
        MusicFolder = "/storage/music";
        DefaultLanguage = "zh-Hans";
      };
    };

    aria2 = {
      enable = true;
      extraArguments = "--check-certificate=false";
      downloadDir = "/storage/aria2";
      rpcSecretFile = builtins.toFile "aria2-rpc-token.txt" "";
    };
  };


  systemd.services.alist = {
    description = "A file list/WebDAV program that supports multiple storages, powered by Gin and Solidjs.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    preStart = ''
      if [ ! -d "/var/lib/alist/data" ]; then
        ${pkgs.alist}/bin/alist admin set admin
      fi
    '';
    serviceConfig = {
      User = "alist";
      Group = "alist";
      ExecStart = ''
        ${pkgs.alist}/bin/alist server
      '';
      RestartSec = 5;
      Restart = "on-failure";
      WorkingDirectory = "/var/lib/alist";
    };
  };
}
