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
    version = "v3.34.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "alist";
      rev = "v3.34.0";
      fetchSubmodules = false;
      sha256 = "sha256-LHkUqOpZk8GZPUis+oX077w8LY7lLwrLu4AO/NvLVeg=";
    };
  };
  alist-web = {
    pname = "alist-web";
    version = "3.34.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "web-dist";
      rev = "3.34.0";
      fetchSubmodules = false;
      sha256 = "sha256-pF2V2P2GTWP2RG2Oxle2yT0O4EsDsrUT4ggkq/auOZw=";
    };
  };
  bingimg = {
    pname = "bingimg";
    version = "TarangireElephants_EN-US8865263185";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.TarangireElephants_EN-US8865263185_UHD.jpg";
      sha256 = "sha256-AtM6VBT641XmeEYAkbWbRXXJbw8YjTjteyLD/SOdUZ4=";
    };
  };
  dbaeumer_vscode-eslint = {
    pname = "dbaeumer_vscode-eslint";
    version = "3.0.5";
    src = fetchurl {
      url = "https://dbaeumer.gallery.vsassets.io/_apis/public/gallery/publisher/dbaeumer/extension/vscode-eslint/3.0.5/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-eslint-3.0.5.zip";
      sha256 = "sha256-qXePnmM3gLPcry/5g3auhvoBUDTDRYZynviwEkN8s7I=";
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
    version = "5122d48dd821932229d2732ab8470b9c96464971";
    src = fetchFromGitHub {
      owner = "naiba";
      repo = "nezha";
      rev = "5122d48dd821932229d2732ab8470b9c96464971";
      fetchSubmodules = false;
      sha256 = "sha256-TGb4xgOBtlNL5mj31wf5Lcce7ui8h+dCTJWjIvwcRxY=";
    };
    date = "2024-05-07";
  };
  pkief_material-icon-theme = {
    pname = "pkief_material-icon-theme";
    version = "5.3.0";
    src = fetchurl {
      url = "https://pkief.gallery.vsassets.io/_apis/public/gallery/publisher/pkief/extension/material-icon-theme/5.3.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-5.3.0.zip";
      sha256 = "sha256-SCiRpqoUy+TKkiOrhjL5dPvYCMlxnEaVUb0Cjiu3674=";
    };
  };
  rust-lang_rust-analyzer = {
    pname = "rust-lang_rust-analyzer";
    version = "0.4.1960";
    src = fetchurl {
      url = "https://rust-lang.gallery.vsassets.io/_apis/public/gallery/publisher/rust-lang/extension/rust-analyzer/0.4.1960/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "rust-analyzer-0.4.1960.zip";
      sha256 = "sha256-YxFopB6FQfYOuyhCHnQ1Fax4byEV3Ew7u8mu9H+noAI=";
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
    version = "3.17.0";
    src = fetchurl {
      url = "https://usernamehw.gallery.vsassets.io/_apis/public/gallery/publisher/usernamehw/extension/errorlens/3.17.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "errorlens-3.17.0.zip";
      sha256 = "sha256-E0EAzYukaiu/DKREEP4HQjRXPAqwB4cP2PwM1B3c0ok=";
    };
  };
  vue_volar = {
    pname = "vue_volar";
    version = "2.0.19";
    src = fetchurl {
      url = "https://vue.gallery.vsassets.io/_apis/public/gallery/publisher/vue/extension/volar/2.0.19/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "volar-2.0.19.zip";
      sha256 = "sha256-QfXJtV0OOpaBXHsENQD7he13JjqBQksMUAmQ5HBv4TQ=";
    };
  };
}
