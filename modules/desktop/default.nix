{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.supportedFilesystems = [ "ntfs" ];
  services.gvfs.enable = true;
  # services.gnome.gnome-keyring.enable = false;
  security.sudo.wheelNeedsPassword = false;
  security.polkit.extraConfig = ''
    polkit.addAdminRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.systemPackages = with pkgs; [
    ## Go ##
    go
    # go_1_21
    gopls
    dlv-dap
    staticcheck
    leetgo
    gcc
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
    unrar
    # gnome-tweaks
    ## Download ##
    wget
    # axel
    # rsync
    # youtube-dl
    # you-get
    ## Editor ##
    vscode-with-extensions
    zed-editor
    # vscodium
    obsidian
    sqlitebrowser
    ## Others ##
    tdesktop
    hugo
    android-tools
    vue-language-server
    # yarn
    # mdbook
    # mitmproxy
    # python3
    # python3Packages.pip
  ];

  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "pcmanfm.desktop";
      "video/mp4" = "mpv.desktop";
    };
  };

  programs.dconf.profiles = {
    user.databases = [
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

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
