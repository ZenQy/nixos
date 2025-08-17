{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ chromium ];
  environment.variables = {
    GOOGLE_DEFAULT_CLIENT_ID = "77185425430.apps.googleusercontent.com";
    GOOGLE_DEFAULT_CLIENT_SECRET = "OTJgUOQcT7lO7GsGZq2G4IlT";
  };

  programs.chromium = {
    enable = true;
    extensions = [
      # PT Plugin Plus
      # "dmmjlmbkigbgpnjfiimhlnbnmppjhpea;https://raw.githubusercontent.com/pt-plugins/PT-Plugin-Plus/gh-pages/update/canary.xml"
      # uBlock Origin
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      # Extension Manager
      # "gjldcdngmdknpinoemndlidpcabkggco"
      # Tampermonkey BETA
      # "gcalenpjmijncebpfijmoaglllgpjagf"
      # scriptcat beta
      "jaehimmlecjmebpekkipmpmbpfhdacom"
      # Stylus
      # "clngdbkpkpeebahjckkjfobafhncgmne"
      # 沙拉查词
      # "cdonnmffkdaoajfknoeeecmchibpmkmg"
      # obsidian-web-clipper
      "cnjifjpddelmedmihgijeibhnjfabmlf"
      # Vue.js devtools
      # "nhdogjmejiglipccpnnnanhbledajbpd"
      # Bitwarden
      "nngceckbapebfimnlniiiahkandclblb"
      # Cookies获取助手
      # "mmcdaoockinhaeiljdmjmnjfndpfpklo"
    ];
    homepageLocation = "https://go.itab.link";

    extraOpts = {
      AutoplayAllowed = false;
      BackgroundModeEnabled = false;
      BrowserSignin = 1;
      DefaultNotificationsSetting = 2;
      ExtensionDeveloperModeSettings = 0;
      ExtensionManifestV2Availability = 2;
      HomepageIsNewTabPage = false;
      PasswordManagerEnabled = false;
      RestoreOnStartup = 4;
      RestoreOnStartupURLs = [ "https://go.itab.link" ];
      ShowHomeButton = true;
      SpellcheckEnabled = false;
      SyncDisabled = false;
      TranslateEnabled = false;
    };
  };
}
