{ config, lib, pkgs, secrets, ... }:

{
  services.nezha-agent = {
    enable = lib.mkDefault true;
    server = secrets.nezha-agent.server;
    passwordFile =
      let
        conf = pkgs.writeText "nezha-agent.conf"
          (config.networking.hostName + secrets.nezha-agent.password);
      in
      builtins.toString conf;
    skipProcess = true;
    skipConnection = true;
    reportDelay = 3;
  };

}
