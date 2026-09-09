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
              path = "${pkgs.wallpapers}/share/image";
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

  # swaylock
  environment.systemPackages = with pkgs; [
    swaylock
  ];
  security.pam.services.swaylock = { };
  environment.etc."swaylock/config".text = ''
    show-failed-attempts
    daemonize
    image=${pkgs.wallpapers}/share/image-blur/swaylock.jpg
    scaling=fill
  '';

}
