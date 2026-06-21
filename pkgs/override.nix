final: prev:

{

  # chromium = prev.chromium.override {
  #   commandLineArgs = "--wayland-text-input-version=3 --force-dark-mode";
  # };

  ariang = prev.ariang.override {
    buildNpmPackage = args: prev.buildNpmPackage (args // { nodejs = prev.nodejs_22; });
  };

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

  komari-agent = prev.komari-agent.overrideAttrs (old: {
    postPatch = ''
      substituteInPlace cmd/autodiscovery.go \
        --replace-quiet "os.Executable()" "os.Getwd()" \
        --replace-quiet "filepath.Dir(execPath)" "execPath"
    '';
  });

}
