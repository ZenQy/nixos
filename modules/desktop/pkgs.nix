{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ## Go ##
    go
    gopls
    leetgo

    ## Rust ##
    rustc
    rustfmt
    cargo
    gcc
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

    ## android ##
    android-tools
    payload-dumper-go
    erofs-utils

    ## Others ##
    tdesktop
    hugo
    # mdbook
    # mitmproxy
    # python3
    # python3Packages.pip
    # dig
    # ghostty
    # putty
    # parted
  ];
}
