{
  secrets,
  pkgs,
  ...
}:

{
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.supportedFilesystems = [ "ntfs" ];
  services.gvfs.enable = true;
  services.speechd.enable = false;
  services.gnome.gnome-keyring.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  networking.nameservers = [
    "223.5.5.5"
    "119.29.29.29"
  ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "pcmanfm.desktop";
      "video/mp4" = "mpv.desktop";
      "x-scheme-handler/mpv" = "mpv.desktop";
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
    inherit (secrets.AI) DEEPSEEK_API_EKY;
  };
}
