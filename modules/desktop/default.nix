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

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons fcitx5-pinyin-zhwiki ];
    fcitx5 = {
      quickPhrase = {
        smile = "（・∀・）";
        angry = "(￣ー￣)";
      };
      settings = {
        globalOptions = {
          "Hotkey/TriggerKeys"."0" = "Control+Shift+Shift_L";
        };
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "shuangpin";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "shuangpin";
          GroupOrder."0" = "Default";
        };
        addons = {
          classicui.globalSection = {
            "Vertical Candidate List" = "False";
            WheelForPaging = "True";
            Font = "Sans 10";
            MenuFont = "Sans 10";
            TrayFont = "Sans Bold 10";
            TrayOutlineColor = "#000000";
            TrayTextColor = "#ffffff";
            PreferTextIcon = "False";
            ShowLayoutNameInIcon = "True";
            UseInputMethodLanguageToDisplayText = "True";
            Theme = "default-dark";
            DarkTheme = "default-dark";
            UseDarkTheme = "False";
            PerScreenDPI = "False";
            ForceWaylandDPI = 0;
            EnableFractionalScale = "True";
          };
          pinyin.globalSection = {
            ShuangpinProfile = "Xiaohe";
            PageSize = 9;
            CloudPinyinEnabled = "True";
            CloudPinyinIndex = 2;
          };
          cloudpinyin.globalSection = {
            Backend = "Baidu";
          };

        };
      };
    };
  };

  # fonts
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "DejaVu Sans"

          "Source Han Sans SC"
          "Source Han Sans TC"
          "Source Han Sans HW"
          "Source Han Sans K"
          "Source Han Sans"
        ];
        serif = [
          "DejaVu Serif"

          "Source Han Serif SC"
          "Source Han Serif TC"
          "Source Han Serif HW"
          "Source Han Serif K"
          "Source Han Serif"
        ];
        monospace = [
          "Source Code Pro"

          "Source Han Sans SC"
          "Source Han Sans TC"
          "Source Han Sans HW"
          "Source Han Sans K"
          "Source Han Sans"
        ];
        emoji = [
          "Noto Emoji"
          "Noto Color Emoji"

          "Font Awesome 6 Free Regular"
          "Font Awesome 6 Free Solid"
          "Font Awesome 6 Brands Regular"
        ];
      };
    };
    packages = with pkgs; [
      noto-fonts-emoji
      font-awesome

      source-code-pro
      source-han-sans
      source-han-serif
    ];
  };

  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.systemPackages = with pkgs; [
    ## Go ##
    go
    gopls
    dlv-dap
    staticcheck
    leetgo
    gcc
    ## Rust ##
    cargo
    rustc
    rustfmt
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
    # anytype
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
    vivaldi
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
