{ pkgs, ... }:

{

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
      noto-fonts-color-emoji
      font-awesome

      source-code-pro
      source-han-sans
      source-han-serif
    ];
  };

}
