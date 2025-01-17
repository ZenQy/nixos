{ pkgs, ... }:

{
  systemd.user.services.wpaperd = {
    description = "Modern wallpaper daemon for Wayland";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
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
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-abort";
    };
  };
}
