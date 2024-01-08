{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
  ];
  programs.chromium = {
    enable = true;
    extensions = [
      # PT Plugin Plus
      # "dmmjlmbkigbgpnjfiimhlnbnmppjhpea;https://raw.githubusercontent.com/ronggang/PT-Plugin-Plus/dev/update/index.xml"
      # uBlock Origin
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      # Extension Manager
      # "gjldcdngmdknpinoemndlidpcabkggco"
      # Tampermonkey BETA
      "gcalenpjmijncebpfijmoaglllgpjagf"
      # Stylus
      # "clngdbkpkpeebahjckkjfobafhncgmne" 
      # 沙拉查词
      "cdonnmffkdaoajfknoeeecmchibpmkmg"
      # Web Clipper
      # "mhfbofiokmppgdliakminbgdgcmbhbac"
      # MaoXian web clipper
      # "kjahokgdcbohofgdidndeiaigkehdjdc"
      # Vue.js devtools
      # "nhdogjmejiglipccpnnnanhbledajbpd"
      # Bitwarden
      "nngceckbapebfimnlniiiahkandclblb"
    ];
    homepageLocation = "https://limestart.cn";

    extraOpts = {
      "HomepageIsNewTabPage" = false;
      "ShowHomeButton" = true;
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = false;
      "TranslateEnabled" = false;
    };
  };
}
