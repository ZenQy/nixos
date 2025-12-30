{ pkgs, ... }:

{

  fonts = {
    fontconfig = {
      enable = true;
      antialias = false;
      cache32Bit = false;
      hinting.enable = false;
      includeUserConf = false;
      subpixel.lcdfilter = "none";
      subpixel.rgba = "rgb";
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
          "DejaVu Sans Mono"
          "Source Han Mono SC"
          "Source Han Mono TC"
          "Source Han Mono HW"
          "Source Han Mono K"
          "Source Han Mono"
        ];
        emoji = [
          "Noto Color Emoji"
          "Symbols Nerd Font"
          "Symbols Nerd Font Mono"
        ];
      };
    };

    packages = with pkgs; [
      noto-fonts-color-emoji
      nerd-fonts.symbols-only

      source-han-sans
      source-han-serif
      source-han-mono
    ];
  };

}
