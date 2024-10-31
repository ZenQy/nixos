{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ chromium ];
  programs.chromium = {
    enable = true;
    extensions = [
      # PT Plugin Plus
      "dmmjlmbkigbgpnjfiimhlnbnmppjhpea;https://raw.githubusercontent.com/pt-plugins/PT-Plugin-Plus/gh-pages/update/canary.xml"
      # uBlock Origin
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      # Extension Manager
      # "gjldcdngmdknpinoemndlidpcabkggco"
      # Tampermonkey BETA
      # "gcalenpjmijncebpfijmoaglllgpjagf"
      # scriptcat
      "ndcooeababalnlpkfedmmbbbgkljhpjf"
      # Stylus
      # "clngdbkpkpeebahjckkjfobafhncgmne"
      # 沙拉查词
      # "cdonnmffkdaoajfknoeeecmchibpmkmg"
      # Web Clipper
      # "mhfbofiokmppgdliakminbgdgcmbhbac"
      # MaoXian web clipper
      # "kjahokgdcbohofgdidndeiaigkehdjdc"
      # Vue.js devtools
      # "nhdogjmejiglipccpnnnanhbledajbpd"
      # Bitwarden
      "nngceckbapebfimnlniiiahkandclblb"
    ];
    homepageLocation = "https://go.itab.link";

    extraOpts = {
      HomepageIsNewTabPage = false;
      ShowHomeButton = true;
      BrowserSignin = 0;
      SyncDisabled = false;
      PasswordManagerEnabled = false;
      SpellcheckEnabled = false;
      TranslateEnabled = false;
      DefaultNotificationsSetting = 2;
      RestoreOnStartup = 4;
      RestoreOnStartupURLs = [ "https://go.itab.link" ];
      AutoplayAllowed = false;
      BackgroundModeEnabled = false;
    };
  };
}
