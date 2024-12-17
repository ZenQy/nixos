# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  ArtemisClient = {
    pname = "ArtemisClient";
    version = "DimLight@build1.0.0";
    src = fetchurl {
      url = "https://github.com/kwaitsing/Artemis/archive/refs/tags/DimLight@build1.0.0.tar.gz";
      name = "Artemis.tar.gz";
      sha256 = "sha256-8E0oz+k8pCZHh27pQj2gzig0m+sivJvSaHYttnabxss=";
    };
  };
  ArtemisServer = {
    pname = "ArtemisServer";
    version = "DimLight@build1.0.0";
    src = fetchurl {
      url = "https://github.com/kwaitsing/Artemis/archive/refs/tags/DimLight@build1.0.0.tar.gz";
      name = "Artemis.tar.gz";
      sha256 = "sha256-8E0oz+k8pCZHh27pQj2gzig0m+sivJvSaHYttnabxss=";
    };
  };
  ArtemisWeb = {
    pname = "ArtemisWeb";
    version = "DimLight@build1.0.0";
    src = fetchurl {
      url = "https://github.com/kwaitsing/Artemis/releases/download/DimLight@build1.0.0/frontend.tar.gz";
      sha256 = "sha256-ryjXR/roxu2Z+txrOd6FTfKzfBXzNN09UiS6RtSnqn8=";
    };
  };
  alist = {
    pname = "alist";
    version = "v3.41.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "alist";
      rev = "v3.41.0";
      fetchSubmodules = false;
      sha256 = "sha256-pGOdTBzAEW8KZAoGMoUgwqkkMFBav86puODNHMvEIBg=";
    };
  };
  alist-web = {
    pname = "alist-web";
    version = "3.41.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "web-dist";
      rev = "3.41.0";
      fetchSubmodules = false;
      sha256 = "sha256-tK1byiwtE9oMmRWEUJGVwenCJRC6CYGIGtl+r+2Nn00=";
    };
  };
  bingimg = {
    pname = "bingimg";
    version = "ReinefjordenNorway_EN-US8636083241";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.ReinefjordenNorway_EN-US8636083241_UHD.jpg";
      sha256 = "sha256-CZcWSf9l8fGG72RYBByL1hgvPw4ygVX+zUsGhlCMYY0=";
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
    version = "v2024.12.02";
    src = fetchurl {
      url = "https://github.com/ZenQy/scel2dict/releases/download/v2024.12.02/zenith.dict";
      sha256 = "sha256-fRXJDPbrWep9A5GmtYY3wLmq3VCFdZdfc3gpF8hQoxY=";
    };
  };
  golang_go = {
    pname = "golang_go";
    version = "0.45.0";
    src = fetchurl {
      url = "https://golang.gallery.vsassets.io/_apis/public/gallery/publisher/golang/extension/go/0.45.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "go-0.45.0.zip";
      sha256 = "sha256-w/74OCM1uAJzjlJ91eDoac6knD1+Imwfy6pXX9otHsY=";
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
    version = "v1.174.0";
    src = fetchurl {
      url = "https://github.com/MetaCubeX/metacubexd/releases/download/v1.174.0/compressed-dist.tgz";
      sha256 = "sha256-IDT/ieT/C6FqYdOCLq/ZgZuNVafrfcHg5POMMmndJig=";
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
  pkief_material-icon-theme = {
    pname = "pkief_material-icon-theme";
    version = "5.16.0";
    src = fetchurl {
      url = "https://pkief.gallery.vsassets.io/_apis/public/gallery/publisher/pkief/extension/material-icon-theme/5.16.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-5.16.0.zip";
      sha256 = "sha256-zzJ/N8DOY/bN75+k7SycK5VCTG9Nx5noh9g3gryQ/D0=";
    };
  };
  rust-lang_rust-analyzer = {
    pname = "rust-lang_rust-analyzer";
    version = "0.4.2221";
    src = fetchurl {
      url = "https://rust-lang.gallery.vsassets.io/_apis/public/gallery/publisher/rust-lang/extension/rust-analyzer/0.4.2221/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "rust-analyzer-0.4.2221.zip";
      sha256 = "sha256-9lsyteFc1vhJOYlRP0lCv1ww734TkCWDhGsAmYcdoFM=";
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
    version = "3.21.0";
    src = fetchurl {
      url = "https://usernamehw.gallery.vsassets.io/_apis/public/gallery/publisher/usernamehw/extension/errorlens/3.21.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "errorlens-3.21.0.zip";
      sha256 = "sha256-E0tSaaoAO68aNK0W1Ji7zthEEnLRzgDZDnDmP4q/Bxk=";
    };
  };
  vitejs = {
    pname = "vitejs";
    version = "v6.0.3";
    src = fetchFromGitHub {
      owner = "vitejs";
      repo = "vite";
      rev = "v6.0.3";
      fetchSubmodules = false;
      sha256 = "sha256-oIgm+Vu695yBQzCBzZCgj3NzVYehXs+BmMEPtUCNYMg=";
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
