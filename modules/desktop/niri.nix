{ pkgs, ... }:
# with builtins;

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.niri}/bin/niri --session";
        user = "nixos";
      };
      default_session = initial_session;
    };
  };

  environment.systemPackages = with pkgs; [
    niri
    fuzzel
  ];
}
