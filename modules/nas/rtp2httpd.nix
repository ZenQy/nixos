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
    systemd.services.rtp2httpd =
      let
        file = "rtp2httpd.conf";
        conf = generators.toINI { } {
          global = {
            external-m3u = "http://10.0.0.12:8080/tv.m3u";
          };
        };
      in
      {
        description = "Multicast RTP/RTSP to Unicast HTTP stream converter";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        path = with pkgs; [
          curl
          which
        ];
        preStart = ''
          cat << EOF > ${file}
          ${conf}
          EOF
        '';
        serviceConfig = {
          StateDirectory = "rtp2httpd";
          WorkingDirectory = "/var/lib/rtp2httpd";
          ExecStart = ''
            ${pkgs.rtp2httpd}/bin/rtp2httpd -c ${file}
          '';
          RestartSec = 5;
          Restart = "on-failure";
        };
      };
  };
}
