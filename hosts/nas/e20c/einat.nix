{ config, pkgs, ... }:

let
  settings = {
    defaults =
      let
        ranges = [ "10000-65535" ];
      in
      {
        tcp_ranges = ranges;
        udp_ranges = ranges;
      };
    interfaces = [
      {
        if_name = config.systemd.network.networks.pppoe.name;
        nat44 = true;
        snat_internals = [ "10.0.0.0/24" ];
      }
    ];
  };
  format = pkgs.formats.toml { };
  conf = format.generate "config.toml" settings;
in
{

  systemd.services.einat = {
    description = "einat Daemon";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.einat}/bin/einat -c ${conf}";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-abort";
    };
  };

}
