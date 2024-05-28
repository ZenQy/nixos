{ config, lib, secrets, ... }:
with builtins;

{
  services.nezha-agent = {
    enable = lib.mkDefault true;
    server = "${secrets.nezha-agent.server}:${toString secrets.nezha-agent.port}";
    passwordFile =
      let
        conf = toFile "nezha-agent.conf"
          (config.networking.hostName + secrets.nezha-agent.password);
      in
      toString conf;
    skipProcess = true;
    skipConnection = true;
    reportDelay = 3;
  };

}
