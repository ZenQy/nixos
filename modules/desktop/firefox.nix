{ ... }:

{
  programs.firefox = {
    enable = true;
    preferences = {
      "media.ffmpeg.vaapi.enabled" = true;
      "media.ffvpx.enabled" = false;
      "gfx.webrender.all" = true;
      "gfx.webrender.compositor" = true;
      "gfx.webrender.compositor.force-enabled" = true;
      "media.hardware-video-decoding.force-enabled" = true;
      "media.autoplay.default" = 0;
      "browser.search.region" = "US";
      "browser.newtabpage.activity-stream.showWeather" = false;
    };
    policies = {
      Homepage = {
        Locked = true;
        StartPage = "homepage-locked";
        URL = "https://go.itab.link";
      };
      ExtensionUpdate = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
        "{8e515334-52b5-4cc5-b4e8-675d50af677d}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/scriptcat/latest.xpi";
        };
        "{e9c422a1-5740-4c0a-a10e-867939119613}" = {
          installation_mode = "force_installed";
          install_url = "https://github.com/pt-plugins/PT-Plugin-Plus/releases/download/v1.6.1.2731/PT-Plugin-Plus-1.6.1.2731.xpi";
        };
      };
    };
  };
}
