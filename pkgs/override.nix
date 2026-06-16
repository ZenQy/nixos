final: prev:

{

  # chromium = prev.chromium.override {
  #   commandLineArgs = "--wayland-text-input-version=3 --force-dark-mode";
  # };

  ariang = prev.ariang.override {
    buildNpmPackage =
      args:
      prev.buildNpmPackage (
        args
        // {
          version = "1.3.14";
          src = prev.fetchFromGitHub {
            owner = "timhae";
            repo = "AriaNg";
            rev = "7d0538b";
            hash = "sha256-iUgUT1Vq0KExDT+xSrbvZDDs48GOk+gE6wPAKooFhuU=";
          };
          npmDepsHash = "sha256-XHoPPrebNgGZnVQmA0d5OeR+ZWJQEdZU4Ibcbd80/oM=";
        }
      );
  };

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
