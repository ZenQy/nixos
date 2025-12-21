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
          punctuation.globalSection = {
            HalfWidthPuncAfterLetterOrNumber = "True";
            TypePairedPunctuationsTogether = "True";
            Enabled = "True";
          };
          pinyin = {
            globalSection = {
              ShuangpinProfile = "Xiaohe";
              ShowShuangpinMode = "True";
              PageSize = 9;
              CloudPinyinEnabled = "False";
              EmojiEnabled = "True";
              FirstRun = "False";
            };
            sections.Fuzzy = builtins.listToAttrs (
              map
                (key: {
                  name = key;
                  value = "False";
                })
                [
                  "VE_UE"
                  "NG_GN"
                  "Inner"
                  "InnerShort"
                  "PartialFinal"
                  "PartialSp"
                  "V_U"
                  "AN_ANG"
                  "EN_ENG"
                  "IAN_IANG"
                  "IN_ING"
                  "U_OU"
                  "UAN_UANG"
                  "C_CH"
                  "F_H"
                  "L_N"
                  "L_R"
                  "S_SH"
                  "Z_ZH"
                ]
            );
          };
        };
      };
    };
  };
}
