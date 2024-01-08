final: prev:
# let
#   sources = (import ./_sources/generated.nix) {
#     inherit (final) fetchgit fetchurl fetchFromGitHub dockerTools;
#   };
# in
{
  vscode-with-extensions = prev.vscode-with-extensions.override {
    vscodeExtensions = with prev; [
      mhutchie_git-graph
      # eamodio_gitlens
      # vue_volar
      # dbaeumer_vscode-eslint
      golang_go
      pkief_material-icon-theme
      jnoortheen_nix-ide
      # github_vscode-github-actions
      rust-lang_rust-analyzer
    ];
  };

  mpv =
    let
      mpv-unwrapped = prev.mpv-unwrapped.overrideAttrs (old: {
        postPatch = old.postPatch + ''
          substituteInPlace meson.build \
            --replace "get_option('sysconfdir'), 'mpv'" "'/etc/mpv'"
        '';
      });
    in
    prev.wrapMpv mpv-unwrapped { scripts = with prev.mpvScripts; [ autoload ]; };

  # hyprland = prev.hyprland.overrideAttrs (old: {
  #   postPatch = old.postPatch + ''
  #     substituteInPlace src/config/ConfigManager.cpp \
  #       --replace 'getenv("XDG_CONFIG_HOME")' '"/etc/xdg"'
  #   '';
  # });

}
