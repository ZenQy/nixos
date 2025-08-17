final: prev:
let
  sources = (import ./_sources/generated.nix) {
    inherit (final)
      fetchgit
      fetchurl
      fetchFromGitHub
      dockerTools
      ;
  };
in
{
  # vscode-with-extensions = prev.vscode-with-extensions.override {
  #   vscode = prev.vscodium.override {
  #     commandLineArgs = "--wayland-text-input-version=3";
  #   };
  #   vscodeExtensions = with prev; [
  #     mhutchie_git-graph
  #     # eamodio_gitlens
  #     vue_volar
  #     # dbaeumer_vscode-eslint
  #     golang_go
  #     pkief_material-icon-theme
  #     jnoortheen_nix-ide
  #     # github_vscode-github-actions
  #     tamasfe_even-better-toml
  #     usernamehw_errorlens
  #     rust-lang_rust-analyzer
  #     SuperMonster003_autojs6-vscode-ext
  #   ];
  # };

  chromium = prev.chromium.override {
    commandLineArgs = "--enable-wayland-ime --wayland-text-input-version=3 --force-dark-mode";
  };

  # vivaldi = prev.vivaldi.override {
  #   proprietaryCodecs = true;
  #   commandLineArgs = "--enable-wayland-ime";
  # };

  obsidian = prev.obsidian.overrideAttrs (old: {
    postInstall = ''
      substituteInPlace $out/bin/obsidian \
        --replace '--ozone-platform=wayland' '--ozone-platform=wayland --wayland-text-input-version=3'
    '';
  });

  mpv =
    let
      mpv-unwrapped = prev.mpv-unwrapped.overrideAttrs (old: {
        postPatch = old.postPatch + ''
          substituteInPlace meson.build \
            --replace "get_option('sysconfdir'), 'mpv'" "'/etc/mpv'"
        '';
      });
    in
    mpv-unwrapped.wrapper {
      mpv = mpv-unwrapped;
      scripts = with mpv-unwrapped.scripts; [ autoload ];
    };

  sing-box = prev.sing-box.overrideAttrs (old: {
    inherit (sources.sing-box) src version;
    vendorHash = "sha256-sWWiPDUEc+EBzLmd+QYYVdecqhKBeKkPABEp6jFqraw=";
    tags = [
      "with_quic"
      "with_dhcp"
      "with_wireguard"
      "with_utls"
      "with_acme"
      "with_clash_api"
      "with_gvisor"
      "with_tailscale"
    ];
  });
}
