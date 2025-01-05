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
  environment.systemPackages = with pkgs; [
    niri
    fuzzel
    swaylock
    swaybg
  ];

  security.pam.services.swaylock = { };

  environment.etc = {
    "niri/config.kdl".text =
      builtins.readFile ./dotfiles/niri/config.kdl
      + ''
        spawn-at-startup  "swaybg" "-i" "${pkgs.bingimg}/share/bingimg.jpg" "-m" "fill"
      '';

    "swaylock/config".text = ''
      show-failed-attempts
      daemonize
      image=${pkgs.bingimg}/share/bingimg-blur.jpg
      scaling=fill
    '';
  };

}
