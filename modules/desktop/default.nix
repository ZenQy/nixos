{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.supportedFilesystems = [ "ntfs" ];
  services.gvfs.enable = true;
  # services.gnome.gnome-keyring.enable = false;
  security.sudo.wheelNeedsPassword = false;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
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
    nil
    nixpkgs-fmt
    ## File Manager ##
    pcmanfm
    numix-icon-theme-circle
    xarchiver
    xdg-utils
    p7zip
    unrar
    ## Download ##
    wget
    # axel
    # rsync
    # youtube-dl
    # you-get
    ## Editor ##
    vscode-with-extensions
    # vscodium
    obsidian
    sqlitebrowser
    ## Others ##
    tdesktop
    hugo
    android-tools
    # nodejs-slim_latest
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
            gtk-theme = "Numix-Circle";
            icon-theme = "Numix-Circle";
          };
        };
      }
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
