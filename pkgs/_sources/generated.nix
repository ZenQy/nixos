# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  SuperMonster003_autojs6-vscode-ext = {
    pname = "SuperMonster003_autojs6-vscode-ext";
    version = "1.0.10";
    src = fetchurl {
      url = "https://003.gallery.vsassets.io/_apis/public/gallery/publisher/003/extension/autojs6-vscode-ext/1.0.10/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "autojs6-vscode-ext-1.0.10.zip";
      sha256 = "sha256-ySsQHqrAZG5oWtVQnMUXM6gzUWzcbrDk8yigMC8NtmY=";
    };
  };
  alist = {
    pname = "alist";
    version = "v3.44.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "alist";
      rev = "v3.44.0";
      fetchSubmodules = false;
      sha256 = "sha256-MgNoqR9RYRZhQSCplZwqQECE+6/33vijjx0AnC0U2QA=";
    };
  };
  alist-web = {
    pname = "alist-web";
    version = "3.44.0";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "web-dist";
      rev = "3.44.0";
      fetchSubmodules = false;
      sha256 = "sha256-nsQihiYJIOd72ppTy1ewZULTzx8agD56mIBztBfhriA=";
    };
  };
  allinone = {
    pname = "allinone";
    version = "latest";
    src = dockerTools.pullImage {
      imageName = "youshandefeiyang/allinone";
      imageDigest = "sha256:6753df040d1cafb397e35c4f0b297958c337b533fab5f6309c213f5170cd1abe";
      sha256 = "sha256-GdPQBs3n4mSfQxySFceoOPWcNEX6ooxdBtKnGtsLcVg=";
      finalImageTag = "latest";
      os = "linux";
      arch = "arm64";
    };
  };
  bingimg = {
    pname = "bingimg";
    version = "ItalyOstuni_EN-US2964422003";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.ItalyOstuni_EN-US2964422003_UHD.jpg";
      sha256 = "sha256-uxKeUUfCPAQSNwKDdNmkNWglaBfajs/yo5PGIUdAyaI=";
    };
  };
  chatgpt-web = {
    pname = "chatgpt-web";
    version = "43b062e32e31f1c61e8d955d49c7100100a75f48";
    src = fetchFromGitHub {
      owner = "xqdoo00o";
      repo = "chatgpt-web";
      rev = "43b062e32e31f1c61e8d955d49c7100100a75f48";
      fetchSubmodules = false;
      sha256 = "sha256-2RY3tdsspya3sHwCakEsZQZTCvUmAV9Mk2kAAnqX14g=";
    };
    date = "2025-02-13";
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
    version = "v1.24.1";
    src = fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v1.24.1";
      fetchSubmodules = false;
      sha256 = "sha256-QAFCJ5oQYHDXrNLptRdAWzzbX6J9XVgnmsB3eZ3Lko8=";
    };
  };
  fcitx5-pinyin-zenith = {
    pname = "fcitx5-pinyin-zenith";
    version = "v2025.03.02";
    src = fetchurl {
      url = "https://github.com/ZenQy/scel2dict/releases/download/v2025.03.02/zenith.dict";
      sha256 = "sha256-ahNqi5bpGJ4LUjnjz5Emkv9sQmQcK91YxsyFLsccI4M=";
    };
  };
  golang_go = {
    pname = "golang_go";
    version = "0.47.1";
    src = fetchurl {
      url = "https://golang.gallery.vsassets.io/_apis/public/gallery/publisher/golang/extension/go/0.47.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "go-0.47.1.zip";
      sha256 = "sha256-FKbPvXIO7SGt9C2lD7+0Q6yD0QNzrdef1ltsYXPmAi0=";
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
    version = "0.4.16";
    src = fetchurl {
      url = "https://jnoortheen.gallery.vsassets.io/_apis/public/gallery/publisher/jnoortheen/extension/nix-ide/0.4.16/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "nix-ide-0.4.16.zip";
      sha256 = "sha256-MdFDOg9uTUzYtRW2Kk4L8V3T/87MRDy1HyXY9ikqDFY=";
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
  linux-armbian = {
    pname = "linux-armbian";
    version = "v24.11.1";
    src = fetchFromGitHub {
      owner = "armbian";
      repo = "linux-rockchip";
      rev = "v24.11.1";
      fetchSubmodules = false;
      sha256 = "sha256-ZqEKQyFeE0UXN+tY8uAGrKgi9mXEp6s5WGyjVuxmuyM=";
    };
  };
  metacubexd = {
    pname = "metacubexd";
    version = "v1.186.1";
    src = fetchurl {
      url = "https://github.com/MetaCubeX/metacubexd/releases/download/v1.186.1/compressed-dist.tgz";
      sha256 = "sha256-0eziX3+6YwPHJREFli/2K7VAo6AnvlSAEGxGTo2fJoo=";
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
    version = "v1.10.0";
    src = fetchFromGitHub {
      owner = "nezhahq";
      repo = "agent";
      rev = "v1.10.0";
      fetchSubmodules = false;
      sha256 = "sha256-Pmfq9yk78mesxSzg7YdrL8KjHL6vRHPrAuNM7StRmus=";
    };
  };
  nezha-dashboard = {
    pname = "nezha-dashboard";
    version = "v1.10.8";
    src = fetchFromGitHub {
      owner = "naiba";
      repo = "nezha";
      rev = "v1.10.8";
      fetchSubmodules = false;
      sha256 = "sha256-uYZclZPvjiOpCVpxkyU6BjdxBmdryBzoGkTctsRuapY=";
    };
  };
  pkief_material-icon-theme = {
    pname = "pkief_material-icon-theme";
    version = "5.20.0";
    src = fetchurl {
      url = "https://pkief.gallery.vsassets.io/_apis/public/gallery/publisher/pkief/extension/material-icon-theme/5.20.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-5.20.0.zip";
      sha256 = "sha256-Z83FXPf8mXcxmzOdk8IG9ZcP/1OYL8pEHEKPc3pZFdo=";
    };
  };
  qd = {
    pname = "qd";
    version = "lite-latest";
    src = dockerTools.pullImage {
      imageName = "qdtoday/qd";
      imageDigest = "sha256:82001a466271f9c1f8faebc053a19b3f956f938220153b599798d2f0805ebafa";
      sha256 = "sha256-DTA6aVyYQFf4+SYfyPh4ekJPqgGhoIaslqIRQpQWaZo=";
      finalImageTag = "lite-latest";
      os = "linux";
      arch = "arm64";
    };
  };
  rust-lang_rust-analyzer = {
    pname = "rust-lang_rust-analyzer";
    version = "0.4.2361";
    src = fetchurl {
      url = "https://rust-lang.gallery.vsassets.io/_apis/public/gallery/publisher/rust-lang/extension/rust-analyzer/0.4.2361/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "rust-analyzer-0.4.2361.zip";
      sha256 = "sha256-W1BKxckiOEvG+0yZF6Hl+MmGCapiMBVw9zYJiz5KYmk=";
    };
  };
  staticcheck = {
    pname = "staticcheck";
    version = "2025.1.1";
    src = fetchFromGitHub {
      owner = "dominikh";
      repo = "go-tools";
      rev = "2025.1.1";
      fetchSubmodules = false;
      sha256 = "sha256-ekSOXaVSFdzM76tcj1hbtzhYw4fnFX3VkTnsGtJanXg=";
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
  usernamehw_errorlens = {
    pname = "usernamehw_errorlens";
    version = "3.24.0";
    src = fetchurl {
      url = "https://usernamehw.gallery.vsassets.io/_apis/public/gallery/publisher/usernamehw/extension/errorlens/3.24.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "errorlens-3.24.0.zip";
      sha256 = "sha256-r5xXR4rDbP+2bk66yqPoLod8IZXFrntcKHuWbAiFWwE=";
    };
  };
  vitejs = {
    pname = "vitejs";
    version = "v6.2.4";
    src = fetchFromGitHub {
      owner = "vitejs";
      repo = "vite";
      rev = "v6.2.4";
      fetchSubmodules = false;
      sha256 = "sha256-u0pTHOCeAgUSY8//+qR/4em5XOpNTnYa9EkCve57bP4=";
    };
  };
  vue_volar = {
    pname = "vue_volar";
    version = "2.2.8";
    src = fetchurl {
      url = "https://vue.gallery.vsassets.io/_apis/public/gallery/publisher/vue/extension/volar/2.2.8/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "volar-2.2.8.zip";
      sha256 = "sha256-efEeTq/y4al38Tdut3bHVdluf3tUYqc6CFPX+ch1gLg=";
    };
  };
  wallpapers = {
    pname = "wallpapers";
    version = "v2025.03.03";
    src = fetchurl {
      url = "https://github.com/ZenQy/wallpaper/releases/download/v2025.03.03/wallpaper.tar.gz";
      sha256 = "sha256-ojPUCxvhFFrGVvLhqmmK9Dyi9VbE/NcE9wsGzkN7QKY=";
    };
  };
}
