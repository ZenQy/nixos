# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alist = {
    pname = "alist";
    version = "v3.39.1";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "alist";
      rev = "v3.39.1";
      fetchSubmodules = false;
      sha256 = "sha256-x8H+1x3mpJHf/sSswpVCDceHL6+TO2jUdSh0MmiksHU=";
    };
  };
  alist-web = {
    pname = "alist-web";
    version = "3.39.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "web-dist";
      rev = "3.39.0";
      fetchSubmodules = false;
      sha256 = "sha256-lwIWR2B0d4JH6rOwa8YL5FN3Q5ap+/rqqI7en9q0+mM=";
    };
  };
  bingimg = {
    pname = "bingimg";
    version = "FrieslandNetherlands_EN-US3770890281";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.FrieslandNetherlands_EN-US3770890281_UHD.jpg";
      sha256 = "sha256-ApdXz7+pM94W2YHl0YaZ6YIIPpKVq5kmBtB8aJuGvro=";
    };
  };
  dbaeumer_vscode-eslint = {
    pname = "dbaeumer_vscode-eslint";
    version = "3.0.13";
    src = fetchurl {
      url = "https://dbaeumer.gallery.vsassets.io/_apis/public/gallery/publisher/dbaeumer/extension/vscode-eslint/3.0.13/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-eslint-3.0.13.zip";
      sha256 = "sha256-l5VvhQPxPaQsPhXUbFW2yGJjaqnNvijn4QkXPjf1WXo=";
    };
  };
  dlv-dap = {
    pname = "dlv-dap";
    version = "v1.23.1";
    src = fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v1.23.1";
      fetchSubmodules = false;
      sha256 = "sha256-+qC5fFBuQchz1dMP5AezWkkD2anZshN1wIteKce0Ecw=";
    };
  };
  fcitx5-pinyin-zenith = {
    pname = "fcitx5-pinyin-zenith";
    version = "v2024.11.02";
    src = fetchurl {
      url = "https://github.com/ZenQy/scel2dict/releases/download/v2024.11.02/zenith.dict";
      sha256 = "sha256-KkAi6VdW/rARwVR+3kP4Xbn4/bbQTTn3osJJyv7jCnc=";
    };
  };
  geoip = {
    pname = "geoip";
    version = "202411";
    src = fetchurl {
      url = "https://ipinfo.io/data/free/country.mmdb?token=6c1123281048d2";
      sha256 = "sha256-EbG63DVzo0kNoSiJOMsjruVDtbAbW76Tp1b6VtDkSSg=";
    };
  };
  golang_go = {
    pname = "golang_go";
    version = "0.43.2";
    src = fetchurl {
      url = "https://golang.gallery.vsassets.io/_apis/public/gallery/publisher/golang/extension/go/0.43.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "go-0.43.2.zip";
      sha256 = "sha256-LFJLU4Vodo8rGgQ5waxlN70jr0TZUMlknmqfx259egE=";
    };
  };
  it-tools = {
    pname = "it-tools";
    version = "2024.10.22-7ca5933";
    src = fetchurl {
      url = "https://github.com/CorentinTh/it-tools/releases/download/v2024.10.22-7ca5933/it-tools-2024.10.22-7ca5933.zip";
      sha256 = "sha256-7vJ21nXbYFO9xlzYSCpWZ4VWHHDu1QNaDgWw5iewmJ0=";
    };
  };
  jnoortheen_nix-ide = {
    pname = "jnoortheen_nix-ide";
    version = "0.3.5";
    src = fetchurl {
      url = "https://jnoortheen.gallery.vsassets.io/_apis/public/gallery/publisher/jnoortheen/extension/nix-ide/0.3.5/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "nix-ide-0.3.5.zip";
      sha256 = "sha256-hiyFZVsZkxpc2Kh0zi3NGwA/FUbetAS9khWxYesxT4s=";
    };
  };
  leetgo = {
    pname = "leetgo";
    version = "v1.4.11";
    src = fetchFromGitHub {
      owner = "j178";
      repo = "leetgo";
      rev = "v1.4.11";
      fetchSubmodules = false;
      sha256 = "sha256-3euD5njhZowFOhR6sYym+qV2+ioYRXbdhSI1V4vhxxI=";
    };
  };
  metacubexd = {
    pname = "metacubexd";
    version = "v1.171.0";
    src = fetchurl {
      url = "https://github.com/MetaCubeX/metacubexd/releases/download/v1.171.0/compressed-dist.tgz";
      sha256 = "sha256-hF4m7dwH6mNHcjQzamTjJepCgoYCVLFVEpJwnzMxqlg=";
    };
  };
  mhutchie_git-graph = {
    pname = "mhutchie_git-graph";
    version = "1.30.0";
    src = fetchurl {
      url = "https://mhutchie.gallery.vsassets.io/_apis/public/gallery/publisher/mhutchie/extension/git-graph/1.30.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "git-graph-1.30.0.zip";
      sha256 = "sha256-sHeaMMr5hmQ0kAFZxxMiRk6f0mfjkg2XMnA4Gf+DHwA=";
    };
  };
  nezha-dashboard = {
    pname = "nezha-dashboard";
    version = "v0.20.13";
    src = fetchFromGitHub {
      owner = "naiba";
      repo = "nezha";
      rev = "v0.20.13";
      fetchSubmodules = false;
      sha256 = "sha256-fJvL2cESQoiW93aj2RHPyZXvP8246Mf8hIRiP/DSRRY=";
    };
  };
  pkief_material-icon-theme = {
    pname = "pkief_material-icon-theme";
    version = "5.14.1";
    src = fetchurl {
      url = "https://pkief.gallery.vsassets.io/_apis/public/gallery/publisher/pkief/extension/material-icon-theme/5.14.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-5.14.1.zip";
      sha256 = "sha256-a3yb5moSyViJRznzABHajWbdKW096Lla26pVeFghpDo=";
    };
  };
  rust-lang_rust-analyzer = {
    pname = "rust-lang_rust-analyzer";
    version = "0.4.2185";
    src = fetchurl {
      url = "https://rust-lang.gallery.vsassets.io/_apis/public/gallery/publisher/rust-lang/extension/rust-analyzer/0.4.2185/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "rust-analyzer-0.4.2185.zip";
      sha256 = "sha256-KATH7eLe4aRqOgE/pyvPrLrFeBGEjb/GJYS9aQs1bfU=";
    };
  };
  staticcheck = {
    pname = "staticcheck";
    version = "2024.1.1";
    src = fetchFromGitHub {
      owner = "dominikh";
      repo = "go-tools";
      rev = "2024.1.1";
      fetchSubmodules = false;
      sha256 = "sha256-VD6WB0Rcwo41MqZUNVlLGl2yRGZKRGGLGBPvS+ISF4c=";
    };
  };
  tamasfe_even-better-toml = {
    pname = "tamasfe_even-better-toml";
    version = "0.19.2";
    src = fetchurl {
      url = "https://tamasfe.gallery.vsassets.io/_apis/public/gallery/publisher/tamasfe/extension/even-better-toml/0.19.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "even-better-toml-0.19.2.zip";
      sha256 = "sha256-JKj6noi2dTe02PxX/kS117ZhW8u7Bhj4QowZQiJKP2E=";
    };
  };
  usernamehw_errorlens = {
    pname = "usernamehw_errorlens";
    version = "3.20.0";
    src = fetchurl {
      url = "https://usernamehw.gallery.vsassets.io/_apis/public/gallery/publisher/usernamehw/extension/errorlens/3.20.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "errorlens-3.20.0.zip";
      sha256 = "sha256-0gCT+u6rfkEcWcdzqRdc4EosROllD/Q0TIOQ4k640j0=";
    };
  };
  vitejs = {
    pname = "vitejs";
    version = "v5.4.11";
    src = fetchFromGitHub {
      owner = "vitejs";
      repo = "vite";
      rev = "v5.4.11";
      fetchSubmodules = false;
      sha256 = "sha256-OBx6Qf8a4Hfxn3up0aISEA5+zG1ld69kvnj+REuuNtU=";
    };
  };
  vue_volar = {
    pname = "vue_volar";
    version = "2.1.10";
    src = fetchurl {
      url = "https://vue.gallery.vsassets.io/_apis/public/gallery/publisher/vue/extension/volar/2.1.10/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "volar-2.1.10.zip";
      sha256 = "sha256-uyMeoJ8EqAEbFhp0SjFw30U6TSw1SAmo1odSf85VLb8=";
    };
  };
}
