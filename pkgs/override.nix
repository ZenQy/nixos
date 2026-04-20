final: prev:

{

  # chromium = prev.chromium.override {
  #   commandLineArgs = "--wayland-text-input-version=3 --force-dark-mode";
  # };

  mpv-unwrapped = prev.mpv-unwrapped.overrideAttrs (old: {
    postPatch = old.postPatch + ''
      substituteInPlace meson.build \
        --replace-quiet "get_option('sysconfdir'), 'mpv'" "'/etc/mpv'"
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
