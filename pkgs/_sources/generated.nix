# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  Yacd-meta = {
    pname = "Yacd-meta";
    version = "b66b1d0393bd284b7a40329f95eae3746bb102be";
    src = fetchFromGitHub {
      owner = "MetaCubeX";
      repo = "Yacd-meta";
      rev = "b66b1d0393bd284b7a40329f95eae3746bb102be";
      fetchSubmodules = false;
      sha256 = "sha256-mbt7OSHNLseXRAQ8YsQL+FVK3EZ74UfbBWRddYBGUYI=";
    };
    date = "2023-12-29";
  };
  alist = {
    pname = "alist";
    version = "v3.32.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "alist";
      rev = "v3.32.0";
      fetchSubmodules = false;
      sha256 = "sha256-SHiPaXIcjMwAb+GLnVvmAkPK4Wv/3mh3AbIGjQMX0qQ=";
    };
  };
  alist-web = {
    pname = "alist-web";
    version = "3.32.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "web-dist";
      rev = "3.32.0";
      fetchSubmodules = false;
      sha256 = "sha256-+aPa+N/6ht/gMKqWf/ugB8PhDME/uH6VGBxp8Pdx2KE=";
    };
  };
  bingimg = {
    pname = "bingimg";
    version = "BistiBlue_EN-US1090853434";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.BistiBlue_EN-US1090853434_UHD.jpg";
      sha256 = "sha256-oLjmtJDiQyQjPPPEApDc8w+r5lQgBDIPl1fK6wPW85k=";
    };
  };
  code-server = {
    pname = "code-server";
    version = "4.22.0";
    src = fetchurl {
      url = "https://github.com/coder/code-server/releases/download/v4.22.0/code-server-4.22.0-linux-arm64.tar.gz";
      sha256 = "sha256-2JbX6BBBX8Rz66jdQbPl3+2YklUy4SoPuleUmurYnJ4=";
    };
  };
  dbaeumer_vscode-eslint = {
    pname = "dbaeumer_vscode-eslint";
    version = "2.4.4";
    src = fetchurl {
      url = "https://dbaeumer.gallery.vsassets.io/_apis/public/gallery/publisher/dbaeumer/extension/vscode-eslint/2.4.4/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-eslint-2.4.4.zip";
      sha256 = "sha256-NJGsMme/+4bvED/93SGojYTH03EZbtKe5LyvocywILA=";
    };
  };
  dlv-dap = {
    pname = "dlv-dap";
    version = "v1.22.1";
    src = fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v1.22.1";
      fetchSubmodules = false;
      sha256 = "sha256-rR84muba8nMrPZAhH+8xXOOxBvKIsU8Xju8tG7BjqBo=";
    };
  };
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "20240210";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20240210.dict";
      sha256 = "sha256-vNHS5n3TqSwpUx2wG26w7rK6jSqrvLANeG2n0vA4iYk=";
    };
  };
  golang_go = {
    pname = "golang_go";
    version = "0.41.1";
    src = fetchurl {
      url = "https://golang.gallery.vsassets.io/_apis/public/gallery/publisher/golang/extension/go/0.41.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "go-0.41.1.zip";
      sha256 = "sha256-tSt0IqRuE3nJgMYvdYUz5QDtzOsKKQqyW2KD1FEhkEQ=";
    };
  };
  jnoortheen_nix-ide = {
    pname = "jnoortheen_nix-ide";
    version = "0.2.2";
    src = fetchurl {
      url = "https://jnoortheen.gallery.vsassets.io/_apis/public/gallery/publisher/jnoortheen/extension/nix-ide/0.2.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "nix-ide-0.2.2.zip";
      sha256 = "sha256-jwOM+6LnHyCkvhOTVSTUZvgx77jAg6hFCCpBqY8AxIg=";
    };
  };
  leetgo = {
    pname = "leetgo";
    version = "v1.4.1";
    src = fetchFromGitHub {
      owner = "j178";
      repo = "leetgo";
      rev = "v1.4.1";
      fetchSubmodules = false;
      sha256 = "sha256-LbY7GGPu2ZwcclCmsE9V421FUi+foR7CXyFHF7GrjQo=";
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
    version = "v0.16.2";
    src = fetchFromGitHub {
      owner = "nezhahq";
      repo = "agent";
      rev = "v0.16.2";
      fetchSubmodules = false;
      sha256 = "sha256-IeD0jEsXsICTTr+6VsOLtH+HZpVk8DR55Z+sv/S28hs=";
    };
  };
  nezha-dashboard = {
    pname = "nezha-dashboard";
    version = "193455c675d148d51035cb42c4b998281cb461fc";
    src = fetchFromGitHub {
      owner = "naiba";
      repo = "nezha";
      rev = "193455c675d148d51035cb42c4b998281cb461fc";
      fetchSubmodules = false;
      sha256 = "sha256-k+RZVr1STBnV2MfL2tzwO2Xjq7KT5tqQioZXRqj2KI8=";
    };
    date = "2024-03-04";
  };
  pkief_material-icon-theme = {
    pname = "pkief_material-icon-theme";
    version = "4.34.0";
    src = fetchurl {
      url = "https://pkief.gallery.vsassets.io/_apis/public/gallery/publisher/pkief/extension/material-icon-theme/4.34.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-4.34.0.zip";
      sha256 = "sha256-xxOEUvMjqJbl8lONB/So2NoIAVPOxysTq2YQY3iHGqo=";
    };
  };
  rust-lang_rust-analyzer = {
    pname = "rust-lang_rust-analyzer";
    version = "0.4.1874";
    src = fetchurl {
      url = "https://rust-lang.gallery.vsassets.io/_apis/public/gallery/publisher/rust-lang/extension/rust-analyzer/0.4.1874/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "rust-analyzer-0.4.1874.zip";
      sha256 = "sha256-Nm9jMEjki/TT04S6ys3XxAtGbsUasiJ/lDHOn5I+XGo=";
    };
  };
  staticcheck = {
    pname = "staticcheck";
    version = "2023.1.7";
    src = fetchFromGitHub {
      owner = "dominikh";
      repo = "go-tools";
      rev = "2023.1.7";
      fetchSubmodules = false;
      sha256 = "sha256-oR3fsvZmeddN75WsxOMcYe/RAIjYz+ba03ADJfDUqNg=";
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
    version = "3.16.0";
    src = fetchurl {
      url = "https://usernamehw.gallery.vsassets.io/_apis/public/gallery/publisher/usernamehw/extension/errorlens/3.16.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "errorlens-3.16.0.zip";
      sha256 = "sha256-Y3M/A5rYLkxQPRIZ0BUjhlkvixDae+wIRUsBn4tREFw=";
    };
  };
  vue_volar = {
    pname = "vue_volar";
    version = "2.0.6";
    src = fetchurl {
      url = "https://vue.gallery.vsassets.io/_apis/public/gallery/publisher/vue/extension/volar/2.0.6/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "volar-2.0.6.zip";
      sha256 = "sha256-pYGTWceR8CatJ/z8ORrzeDAgrerwpMi/XkguIGRqiGo=";
    };
  };
}
