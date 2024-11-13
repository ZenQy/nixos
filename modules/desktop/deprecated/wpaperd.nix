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
              path = "${pkgs.bingimg}/share/bingimg.jpg";
              mode = "stretch";
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
