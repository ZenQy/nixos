{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "niri-session";
        user = "nixos";
      };
      default_session = initial_session;
    };
  };

  # programs.niri.enable = true;
  xdg.portal = with pkgs; {
    enable = true;
    configPackages = [
      niri
    ];
    extraPortals = [
      xdg-desktop-portal-gtk
    ];
  };
  environment.systemPackages = with pkgs; [
    niri
    fuzzel
    swaylock
    swaybg
  ];

  security.pam.services.swaylock = { };

  environment.etc = {
    "niri/config.kdl".source = ./dotfiles/niri/config.kdl;

    "swaylock/config".text = ''
      show-failed-attempts
      daemonize
      image=${pkgs.bingimg}/share/bingimg-blur.jpg
      scaling=fill
    '';
  };

}
