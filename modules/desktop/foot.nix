{ ... }:

{

  programs.foot = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = false;
    enableZshIntegration = false;
    theme = "ayu-mirage";
    settings = {
      main = {
        font = "monospace:size=14";
        box-drawings-uses-font-glyphs = "yes";
        dpi-aware = "no";
        pad = "0x0center";
      };
      url = {
        launch = "xdg-open \${url}";
        osc8-underline = "url-mode";
      };
    };
  };

}
