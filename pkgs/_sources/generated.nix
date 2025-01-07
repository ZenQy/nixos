# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
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
    version = "BouldersNZ_EN-US0112829210";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.BouldersNZ_EN-US0112829210_UHD.jpg";
      sha256 = "sha256-XKhaiCrz+dA23Zwo92sRyOxgElY848rqT1y1sN5v5a0=";
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
    version = "v1.24.0";
    src = fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v1.24.0";
      fetchSubmodules = false;
      sha256 = "sha256-R1MTMRAIceHv9apKTV+k4d8KoBaRJSZCflxqhgfQWu4=";
    };
  };
  fcitx5-pinyin-zenith = {
    pname = "fcitx5-pinyin-zenith";
    version = "v2025.01.02";
    src = fetchurl {
      url = "https://github.com/ZenQy/scel2dict/releases/download/v2025.01.02/zenith.dict";
      sha256 = "sha256-84yPARhoBqySO/Otmrx3b7KlGaemm8Q05pupMWwQc70=";
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
    version = "v1.4.13";
    src = fetchFromGitHub {
      owner = "j178";
      repo = "leetgo";
      rev = "v1.4.13";
      fetchSubmodules = false;
      sha256 = "sha256-KEfRsaBsMCKO66HW71gNzHzZkun1yo6a05YqAvafomM=";
    };
  };
  metacubexd = {
    pname = "metacubexd";
    version = "v1.176.1";
    src = fetchurl {
      url = "https://github.com/MetaCubeX/metacubexd/releases/download/v1.176.1/compressed-dist.tgz";
      sha256 = "sha256-ThoTrvItuHT2K5PBcuKOkABe6fTDSRnMKBeTQaTWvgg=";
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
  nezha-agent = {
    pname = "nezha-agent";
    version = "v1.5.3";
    src = fetchFromGitHub {
      owner = "nezhahq";
      repo = "agent";
      rev = "v1.5.3";
      fetchSubmodules = false;
      sha256 = "sha256-yImkM/rbLTvqw3glrqSUO0pjQzTDR8HRR6bNrOI12w8=";
    };
  };
  nezha-dashboard = {
    pname = "nezha-dashboard";
    version = "v1.5.12";
    src = fetchFromGitHub {
      owner = "naiba";
      repo = "nezha";
      rev = "v1.5.12";
      fetchSubmodules = false;
      sha256 = "sha256-I4Rqgf2wt0GgnjlqhSDULNv4DMgR2S35/Ka7jmaRJ3g=";
    };
  };
  nezha-theme-admin = {
    pname = "nezha-theme-admin";
    version = "v1.5.12";
    src = fetchurl {
      url = "https://github.com/nezhahq/admin-frontend/releases/download/v1.5.12/dist.zip";
      sha256 = "sha256-PQna09mm3CbDMicdV0J64WwFvoLAEvQktTyDH9t9F0o=";
    };
  };
  nezha-theme-user = {
    pname = "nezha-theme-user";
    version = "v1.12.3";
    src = fetchurl {
      url = "https://github.com/hamster1963/nezha-dash-v1/releases/download/v1.12.3/dist.zip";
      sha256 = "sha256-f8qooewiWCD1KtwZya/kJCwUddRcomYbdE0H9qRRkXE=";
    };
  };
  pkief_material-icon-theme = {
    pname = "pkief_material-icon-theme";
    version = "5.17.0";
    src = fetchurl {
      url = "https://pkief.gallery.vsassets.io/_apis/public/gallery/publisher/pkief/extension/material-icon-theme/5.17.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-5.17.0.zip";
      sha256 = "sha256-ohiWl/ymoWSRyL2pY9DabXfIrofL/oCDKPqvISpgUtU=";
    };
  };
  rust-lang_rust-analyzer = {
    pname = "rust-lang_rust-analyzer";
    version = "0.4.2252";
    src = fetchurl {
      url = "https://rust-lang.gallery.vsassets.io/_apis/public/gallery/publisher/rust-lang/extension/rust-analyzer/0.4.2252/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "rust-analyzer-0.4.2252.zip";
      sha256 = "sha256-km57TwSSqb3H44nAejP5TTjbn5WwRkfQXhQsf5DMwso=";
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
    version = "0.21.2";
    src = fetchurl {
      url = "https://tamasfe.gallery.vsassets.io/_apis/public/gallery/publisher/tamasfe/extension/even-better-toml/0.21.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "even-better-toml-0.21.2.zip";
      sha256 = "sha256-IbjWavQoXu4x4hpEkvkhqzbf/NhZpn8RFdKTAnRlCAg=";
    };
  };
  tv = {
    pname = "tv";
    version = "20250105234451";
    src = fetchurl {
      url = "https://pan.v1.mk/d/%E6%AF%8F%E6%9C%9F%E8%A7%86%E9%A2%91%E4%B8%AD%E7%94%A8%E5%88%B0%E7%9A%84%E6%96%87%E4%BB%B6%E5%88%86%E4%BA%AB/allinone%E4%BA%8C%E8%BF%9B%E5%88%B6%E6%96%87%E4%BB%B6/allinone_linux_arm64_20250105234451.zip";
      sha256 = "sha256-VAy45E9jR/y0aKUpDnQsU9LmeyE+POV4XdOF2JLDs2E=";
    };
  };
  usernamehw_errorlens = {
    pname = "usernamehw_errorlens";
    version = "3.22.0";
    src = fetchurl {
      url = "https://usernamehw.gallery.vsassets.io/_apis/public/gallery/publisher/usernamehw/extension/errorlens/3.22.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "errorlens-3.22.0.zip";
      sha256 = "sha256-Uu2yJr5gxyCZdMK9NSwnBZcVQbG+uS5TtQlSZpyxd50=";
    };
  };
  vitejs = {
    pname = "vitejs";
    version = "v6.0.7";
    src = fetchFromGitHub {
      owner = "vitejs";
      repo = "vite";
      rev = "v6.0.7";
      fetchSubmodules = false;
      sha256 = "sha256-Z5Z2pb0km1PQHqKuQim1g6qZjwK3PuK361cm6Rqb7Fg=";
    };
  };
  vue_volar = {
    pname = "vue_volar";
    version = "2.2.0";
    src = fetchurl {
      url = "https://vue.gallery.vsassets.io/_apis/public/gallery/publisher/vue/extension/volar/2.2.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "volar-2.2.0.zip";
      sha256 = "sha256-4aZX1/ja7rneT4mPTCL4PNWDRQz1SDs7KAVI0NtbTFs=";
    };
  };
}
