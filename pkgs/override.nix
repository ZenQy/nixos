final: prev:

{

  # chromium = prev.chromium.override {
  #   commandLineArgs = "--wayland-text-input-version=3 --force-dark-mode";
  # };

  # ariang = prev.ariang.override {
  # buildNpmPackage = args: prev.buildNpmPackage (args // { nodejs = prev.nodejs_22; });
  # };

  mpv-unwrapped = prev.mpv-unwrapped.overrideAttrs (old: {
    postPatch = old.postPatch + ''
      substituteInPlace meson.build \
        --replace-quiet "get_option('sysconfdir'), 'mpv'" "'/etc/mpv'"
    '';
  });

  yt-dlp = prev.yt-dlp.overrideAttrs (old: {
    postPatch = old.postPatch + ''
      substituteInPlace yt_dlp/extractor/bilibili.py \
        --replace-quiet "https://api.bilibili.com/x/player/wbi/playurl" \
        "https://api.bilibili.com/x/player/playurl"
    '';
  });

  # sing-box = prev.sing-box.overrideAttrs (old: {
  #   version = "1.14.1";
  #   src = prev.fetchFromGitHub {
  #     owner = "SagerNet";
  #     repo = "sing-box";
  #     tag = "v1.14.1";
  #     hash = "sha256-Ce1eukO8ERZEKUoqwcJEJIZcO6VcG/cRnfCdg4FCYJw=";
  #   };
  #   vendorHash = "sha256-ttkDc8vRomNMNwqrZcGuvS0/M7Yqrpkz/h8wO5IVRQ4=";
  # });

  # komari-agent = prev.komari-agent.overrideAttrs (old: {
  #   postPatch = ''
  #     substituteInPlace cmd/autodiscovery.go \
  #       --replace-quiet "os.Executable()" "os.Getwd()" \
  #       --replace-quiet "filepath.Dir(execPath)" "execPath"
  #   '';
  # });

}
