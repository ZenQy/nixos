{
  secrets,
  lib,
  pkgs,
  ...
}:

{
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.supportedFilesystems = [ "ntfs" ];
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = lib.mkForce false;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "pcmanfm.desktop";
      "video/mp4" = "mpv.desktop";
    };
  };

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            cursor-theme = "Nordzy-cursors";
            font-hinting = "medium";
            gtk-theme = "HighContrastInverse";
            icon-theme = "Nordzy-dark";
          };
        };
      }
    ];
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    inherit (secrets.AI) ANTHROPIC_API_EKY;
  };
}
