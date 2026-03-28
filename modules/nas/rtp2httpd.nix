{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.zenith.rtp2httpd;
in

{
  options = {
    zenith.rtp2httpd = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "是否启用rtp2httpd";
      };
    };
  };

  config = mkIf cfg.enable {
    # environment.etc.<name>.text
    systemd.services.rtp2httpd =
      let
        dir = "/var/lib/rtp2httpd";
        settings = {
          global = {
            external-m3u = "http://10.0.0.12:8080/tv.m3u";
          };
        };
      in
      {
        description = "Multicast RTP/RTSP to Unicast HTTP stream converter";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        preStart = ''
          cat ${generators.toINI { } settings} > rtp2httpd.conf
        '';
        serviceConfig = {
          StateDirectory = "rtp2httpd";
          WorkingDirectory = dir;
          ExecStart = ''
            ${pkgs.rtp2httpd}/bin/rtp2httpd -c rtp2httpd.conf
          '';
          RestartSec = 5;
          Restart = "on-failure";
        };
      };
  };
}
