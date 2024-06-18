{ lib, secrets, ... }:

{
  services.nezha-agent = {
    enable = lib.mkDefault true;
    server = "${secrets.nezha-agent.server}:${toString secrets.nezha-agent.port}";
    passwordFile = "/etc/machine-id";
    skipProcess = true;
    skipConnection = true;
    reportDelay = 3;
  };

}
