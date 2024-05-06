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
    version = "TheRoachesPeakDistrict_EN-US9733115206";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.TheRoachesPeakDistrict_EN-US9733115206_UHD.jpg";
      sha256 = "sha256-hx99KmOYBmADjsWWqMiXuKrY5GHCRl6nCWxEAUGNBdU=";
    };
  };
  code-server = {
    pname = "code-server";
    version = "4.23.1";
    src = fetchurl {
      url = "https://github.com/coder/code-server/releases/download/v4.23.1/code-server-4.23.1-linux-arm64.tar.gz";
      sha256 = "sha256-0uGNA6JDS8p/cKJYcN89VxKDWCFyQQw84Fsbtbuhpxs=";
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
    version = "20240426";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20240426.dict";
      sha256 = "sha256-SiiF4kvQpgjAFd3122WYy0ReJkVLUc93JVeFHIqc+jg=";
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
    version = "v1.4.6";
    src = fetchFromGitHub {
      owner = "j178";
      repo = "leetgo";
      rev = "v1.4.6";
      fetchSubmodules = false;
      sha256 = "sha256-f9rDqBTk9f0/ausq4U0Cbb2cOPs4+aP46DEKHeFfrDM=";
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
    version = "v0.16.6";
    src = fetchFromGitHub {
      owner = "nezhahq";
      repo = "agent";
      rev = "v0.16.6";
      fetchSubmodules = false;
      sha256 = "sha256-+78WrkFMY2dfqU3ShmzQgR1ZgEKyb9COUjlIf695OM8=";
    };
  };
  nezha-dashboard = {
    pname = "nezha-dashboard";
    version = "3614ef381ea797af3c4638485882dd26fb36805f";
    src = fetchFromGitHub {
      owner = "naiba";
      repo = "nezha";
      rev = "3614ef381ea797af3c4638485882dd26fb36805f";
      fetchSubmodules = false;
      sha256 = "sha256-g4CmBTctTOHlW4lDPEaAwm6iHECqvKMtf5Pq4pG/cmA=";
    };
    date = "2024-05-05";
  };
  pkief_material-icon-theme = {
    pname = "pkief_material-icon-theme";
    version = "5.1.0";
    src = fetchurl {
      url = "https://pkief.gallery.vsassets.io/_apis/public/gallery/publisher/pkief/extension/material-icon-theme/5.1.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-5.1.0.zip";
      sha256 = "sha256-UuCYYRR0TDfn2DBznpidHeO3ROc/AVgnf7OYcTLeTDI=";
    };
  };
  rust-lang_rust-analyzer = {
    pname = "rust-lang_rust-analyzer";
    version = "0.4.1949";
    src = fetchurl {
      url = "https://rust-lang.gallery.vsassets.io/_apis/public/gallery/publisher/rust-lang/extension/rust-analyzer/0.4.1949/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "rust-analyzer-0.4.1949.zip";
      sha256 = "sha256-POXYwuRIWbhJVHpp4WDBhs2fp63bVtcujXd2HcFAiEI=";
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
    version = "2.0.16";
    src = fetchurl {
      url = "https://vue.gallery.vsassets.io/_apis/public/gallery/publisher/vue/extension/volar/2.0.16/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "volar-2.0.16.zip";
      sha256 = "sha256-RTBbF7qahYP4L7SZ/5aCM/e5crZAyyPRcgL48FVL1jk=";
    };
  };
}
