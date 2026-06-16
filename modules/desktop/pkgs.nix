{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ## Go ##
    go
    gopls
    # leetgo

    ## Rust ##
    # rustc-unwrapped
    rustc
    rust-analyzer
    rustfmt
    cargo
    gcc
    # pkg-config
    # openssl

    ## Nix ##
    # nil
    nixfmt
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
    yt-dlp
    # you-get

    ## Editor ##
    # vscode-with-extensions
    # vscodium
    zed-editor
    claude-code
    obsidian
    sqlitebrowser

    ## android ##
    android-tools
    payload-dumper-go
    erofs-utils

    ## Others ##
    telegram-desktop
    hugo
    tio
    jq
    # pup
    # mdbook
    # mitmproxy
    # python3
    # python3Packages.pip
    # dig
    # ghostty
    # parted
  ];
}
