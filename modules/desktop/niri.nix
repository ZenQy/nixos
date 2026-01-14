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
  ];

  environment.etc."niri/config.kdl".source = ./conf/niri.kdl;

}
