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
  security.sudo.wheelNeedsPassword = false;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  environment.systemPackages = with pkgs; [
    ## Go ##
    go
    gopls
    leetgo
    # gcc

    ## Rust ##
    rustc
    rustfmt
    cargo
    rust-analyzer

    ## Nix ##
    # nil
    nixfmt-rfc-style
    nixd

    ## File Manager ##
    pcmanfm
    nordzy-icon-theme
    nordzy-cursor-theme
    xarchiver
    xdg-utils
    p7zip
    xz
    unrar
    # gnome-tweaks

    ## Download ##
    wget
    # axel
    # rsync
    # youtube-dl
    # you-get

    ## Editor ##
    # vscode-with-extensions
    zed-editor
    # vscodium
    obsidian
    sqlitebrowser

    ## Others ##
    tdesktop
    # hugo
    # android-tools
    # mdbook
    # mitmproxy
    # python3
    # python3Packages.pip
    # dig
    # ghostty
    # putty
    # parted
  ];

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
