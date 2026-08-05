{ pkgs, secrets, ... }:

{
  systemd.timers = {
    yx-tools = {
      enable = true;
      timerConfig.OnCalendar = "Sun *-*-* 21:00:00";
      wantedBy = [ "timers.target" ];
    };
  };
  systemd.services = {
    yx-tools = {
      enable = true;
      path = with pkgs; [ yx ];
      serviceConfig = {
        StateDirectory = "yx-tools";
        WorkingDirectory = "/var/lib/yx-tools";
        ExecStart =
          let
            cfg = secrets.sing-box.cloudflare;
          in
          ''
            yx test -colo HKG,SIN -n 10 -upload api -domain ${cfg.host} -uuid ${cfg.uuid} -clear
          '';
      };
    };
  };
}
