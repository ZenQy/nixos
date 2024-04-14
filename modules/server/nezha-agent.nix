{ config, lib, pkgs, secrets, ... }:

{
  services.nezha-agent = {
    enable = lib.mkDefault true;
    server = secrets.nezha-agent.server;
    passwordFile = pkgs.writeText "nezha-agent.conf"
      (config.networking.hostName + secrets.nezha-agent.password);
    skipProcess = true;
    skipConnection = true;
    reportDelay = 3;
  };

}
