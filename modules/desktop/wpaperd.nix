{ pkgs, ... }:

{
  systemd.user.services.wpaperd = {
    description = "Modern wallpaper daemon for Wayland";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart =
        let
          settings = {
            any = {
              path = "${pkgs.wallpapers}/share";
              mode = "stretch";
              sorting = "random";
            };
          };
          conf = (pkgs.formats.toml { }).generate "config.toml" settings;
        in
        ''
          ${pkgs.wpaperd}/bin/wpaperd -c ${conf}
        '';
      ExecReload = "kill -SIGUSR2 $MAINPID";
      Restart = "on-failure";
    };
  };
}