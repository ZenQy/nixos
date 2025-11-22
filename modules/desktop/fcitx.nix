{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-pinyin-zenith
      ];
      quickPhrase = {
        smile = "（・∀・）";
        angry = "(￣ー￣)";
      };
      settings = {
        globalOptions = {
          "Hotkey/TriggerKeys"."0" = "Control+Shift+Shift_L";
          "Behavior/DisabledAddons"."0" = "fcitx4frontend";
          "Behavior/DisabledAddons"."1" = "ibusfrontend";
          "Behavior/DisabledAddons"."2" = "xim";
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
            EmojiEnabled = "True";
          };
          cloudpinyin.globalSection = {
            Backend = "Baidu";
          };

        };
      };
    };
  };
}
