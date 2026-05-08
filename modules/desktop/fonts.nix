{ pkgs, ... }:

{

  fonts = {
    fontconfig = {
      enable = true;
      cache32Bit = false;
      hinting.enable = false;
      includeUserConf = false;
      defaultFonts = {
        sansSerif = [
          "DejaVu Sans"
          "Noto Sans CJK SC"
          "Noto Sans CJK TC"
          "Noto Sans CJK HK"
          "Noto Sans CJK KR"
          "Noto Sans CJK JP"
        ];
        serif = [
          "DejaVu Serif"
          "Noto Serif CJK SC"
          "Noto Serif CJK TC"
          "Noto Serif CJK HK"
          "Noto Serif CJK KR"
          "Noto Serif CJK JP"
        ];
        monospace = [
          "DejaVu Sans Mono"
          "Noto Sans Mono CJK SC"
          "Noto Sans Mono CJK TC"
          "Noto Sans Mono CJK HK"
          "Noto Sans Mono CJK KR"
          "Noto Sans Mono CJK JP"
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

      noto-fonts-cjk-sans-static
      noto-fonts-cjk-serif-static
    ];
  };
}
