# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  Yacd-meta = {
    pname = "Yacd-meta";
    version = "186b3a3d4ba5590d9525b90fafcadace043788ac";
    src = fetchFromGitHub {
      owner = "MetaCubeX";
      repo = "Yacd-meta";
      rev = "186b3a3d4ba5590d9525b90fafcadace043788ac";
      fetchSubmodules = false;
      sha256 = "sha256-n0MWfM8kQvQSZcg4Ri/QNZ1vUIwa0xRdmAhEC4YLmJU=";
    };
    date = "2024-06-27";
  };
  alist = {
    pname = "alist";
    version = "v3.35.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "alist";
      rev = "v3.35.0";
      fetchSubmodules = false;
      sha256 = "sha256-N9WgaPzc8cuDN7N0Ny3t6ARGla0lCluzF2Mut3Pg880=";
    };
  };
  alist-web = {
    pname = "alist-web";
    version = "3.35.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "web-dist";
      rev = "3.35.0";
      fetchSubmodules = false;
      sha256 = "sha256-DGUTyPhzjV5aqKBhl+UIas/epiiqPdmIUqn1uGLDAyo=";
    };
  };
  bingimg = {
    pname = "bingimg";
    version = "ConwyRiver_EN-US4472231451";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.ConwyRiver_EN-US4472231451_UHD.jpg";
      sha256 = "sha256-R7H1cSd3LXJSAC0urkwWUe5m73n91F9Nk9NYHU2Skq0=";
    };
  };
  dbaeumer_vscode-eslint = {
    pname = "dbaeumer_vscode-eslint";
    version = "3.0.10";
    src = fetchurl {
      url = "https://dbaeumer.gallery.vsassets.io/_apis/public/gallery/publisher/dbaeumer/extension/vscode-eslint/3.0.10/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-eslint-3.0.10.zip";
      sha256 = "sha256-EVmexnTIQQDmj25/rql3eCfJd47zRui3TpHol6l0Vgs=";
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
    version = "20240509";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.5/zhwiki-20240509.dict";
      sha256 = "sha256-uRpKPq+/xJ8akKB8ol/JRF79VfDIQ8L4SxLDXzpfPxg=";
    };
  };
  golang_go = {
    pname = "golang_go";
    version = "0.41.4";
    src = fetchurl {
      url = "https://golang.gallery.vsassets.io/_apis/public/gallery/publisher/golang/extension/go/0.41.4/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "go-0.41.4.zip";
      sha256 = "sha256-ntrEI/l+UjzqGJmtyfVf/+sZJstZy3fm/PSWKTd7/Q0=";
    };
  };
  it-tools = {
    pname = "it-tools";
    version = "2024.5.13-a0bc346";
    src = fetchurl {
      url = "https://github.com/CorentinTh/it-tools/releases/download/v2024.5.13-a0bc346/it-tools-2024.5.13-a0bc346.zip";
      sha256 = "sha256-nqcSx/7BdmOtib/q+XZHe2ENC54dcTpgVsFQaaySZJM=";
    };
  };
  jnoortheen_nix-ide = {
    pname = "jnoortheen_nix-ide";
    version = "0.3.1";
    src = fetchurl {
      url = "https://jnoortheen.gallery.vsassets.io/_apis/public/gallery/publisher/jnoortheen/extension/nix-ide/0.3.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "nix-ide-0.3.1.zip";
      sha256 = "sha256-05oMDHvFM/dTXB6T3rcDK3EiNG2T0tBN9Au9b+Bk7rI=";
    };
  };
  leetgo = {
    pname = "leetgo";
    version = "v1.4.7";
    src = fetchFromGitHub {
      owner = "j178";
      repo = "leetgo";
      rev = "v1.4.7";
      fetchSubmodules = false;
      sha256 = "sha256-K/PaQakX0ZLu2Uh906kZ4p8J+GV7ewAeSVFMMQiKYBA=";
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
    version = "0501e120f64e48b1b564d53e2c485ccf703ec6d5";
    src = fetchFromGitHub {
      owner = "naiba";
      repo = "nezha";
      rev = "0501e120f64e48b1b564d53e2c485ccf703ec6d5";
      fetchSubmodules = false;
      sha256 = "sha256-SGo6TE8jKagBFvX4iR96IO5nRzTdHnOKMO1gA+wi31k=";
    };
    date = "2024-07-04";
  };
  pkief_material-icon-theme = {
    pname = "pkief_material-icon-theme";
    version = "5.4.2";
    src = fetchurl {
      url = "https://pkief.gallery.vsassets.io/_apis/public/gallery/publisher/pkief/extension/material-icon-theme/5.4.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-5.4.2.zip";
      sha256 = "sha256-Akb8JeNLs/7B0FXFeHjEXZSs5P34gIzXlpiOwDYzfKk=";
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
    version = "3.20.0";
    src = fetchurl {
      url = "https://usernamehw.gallery.vsassets.io/_apis/public/gallery/publisher/usernamehw/extension/errorlens/3.20.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "errorlens-3.20.0.zip";
      sha256 = "sha256-0gCT+u6rfkEcWcdzqRdc4EosROllD/Q0TIOQ4k640j0=";
    };
  };
  vue_volar = {
    pname = "vue_volar";
    version = "2.0.26";
    src = fetchurl {
      url = "https://vue.gallery.vsassets.io/_apis/public/gallery/publisher/vue/extension/volar/2.0.26/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "volar-2.0.26.zip";
      sha256 = "sha256-EeJT4lG361TwpsvTVO0oFosHBtWnyiSRyCVcCsjpSBI=";
    };
  };
}
