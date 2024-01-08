# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  bingimg = {
    pname = "bingimg";
    version = "CrabappleChaffinch_EN-US1781584314";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.CrabappleChaffinch_EN-US1781584314_UHD.jpg";
      sha256 = "sha256-JVN4fZ1M4cIlFzf2DjhO1suz+zdk95UM0yzi76yCcFc=";
    };
  };
  dbaeumer_vscode-eslint = {
    pname = "dbaeumer_vscode-eslint";
    version = "2.4.2";
    src = fetchurl {
      url = "https://dbaeumer.gallery.vsassets.io/_apis/public/gallery/publisher/dbaeumer/extension/vscode-eslint/2.4.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-eslint-2.4.2.zip";
      sha256 = "sha256-eIjaiVQ7PNJUtOiZlM+lw6VmW07FbMWPtY7UoedWtbw=";
    };
  };
  dlv-dap = {
    pname = "dlv-dap";
    version = "v1.22.0";
    src = fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v1.22.0";
      fetchSubmodules = false;
      sha256 = "sha256-uYUl8PMBRf73wwo+oOYda0sTfD1gnDThtNc3sg8Q328=";
    };
  };
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "20231205";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20231205.dict";
      sha256 = "sha256-crMmSqQ7QgmjgEG8QpvBgQYfvttCUsKYo8gHZGXIZmc=";
    };
  };
  golang_go = {
    pname = "golang_go";
    version = "0.40.1";
    src = fetchurl {
      url = "https://golang.gallery.vsassets.io/_apis/public/gallery/publisher/golang/extension/go/0.40.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "go-0.40.1.zip";
      sha256 = "sha256-KeYui/REV9E1HcNWBb0ThD0fOWkMM0AVTyfiE1efhCA=";
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
    version = "v1.4";
    src = fetchFromGitHub {
      owner = "j178";
      repo = "leetgo";
      rev = "v1.4";
      fetchSubmodules = false;
      sha256 = "sha256-W1uQFUekgARQ113GRz77ZGQS7/yCUhPZZ+Sf124fuyo=";
    };
  };
  logseq = {
    pname = "logseq";
    version = "0.10.3";
    src = fetchurl {
      url = "https://github.com/logseq/logseq/releases/download/0.10.3/logseq-linux-x64-0.10.3.zip";
      sha256 = "sha256-9ycDoIB3OHPGEGWH4w6RUG2sEUrQ9rMzgxcfDMKm1eU=";
    };
  };
  markdown-online-editor = {
    pname = "markdown-online-editor";
    version = "58f9fcb534a4f46ff2b7d5cce4553193c02d5781";
    src = fetchFromGitHub {
      owner = "nicejade";
      repo = "markdown-online-editor";
      rev = "58f9fcb534a4f46ff2b7d5cce4553193c02d5781";
      fetchSubmodules = false;
      sha256 = "sha256-cegrijki70tmOVLq2eWT4KYIQ7wwdIFcAOwclfEAcWY=";
    };
    date = "2023-06-14";
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
    version = "v0.15.16";
    src = fetchFromGitHub {
      owner = "nezhahq";
      repo = "agent";
      rev = "v0.15.16";
      fetchSubmodules = false;
      sha256 = "sha256-YxFQMY24kGgGXQD5ZxrV6Y654rRAKEVElKq5sNkCt2I=";
    };
  };
  nezha-dashboard = {
    pname = "nezha-dashboard";
    version = "11bcc47d49ae65a2d6368b115ea4a504c9b4c39c";
    src = fetchFromGitHub {
      owner = "naiba";
      repo = "nezha";
      rev = "11bcc47d49ae65a2d6368b115ea4a504c9b4c39c";
      fetchSubmodules = false;
      sha256 = "sha256-k3p1fL+eeUKKZGjR67XfVZwnt70eWODZc0++y7qZKsQ=";
    };
    date = "2023-12-26";
  };
  pkief_material-icon-theme = {
    pname = "pkief_material-icon-theme";
    version = "4.32.0";
    src = fetchurl {
      url = "https://pkief.gallery.vsassets.io/_apis/public/gallery/publisher/pkief/extension/material-icon-theme/4.32.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "material-icon-theme-4.32.0.zip";
      sha256 = "sha256-6I9/nWv449PgO1tHJbLy/wxzG6BQF6X550l3Qx0IWpw=";
    };
  };
  rust-lang_rust-analyzer = {
    pname = "rust-lang_rust-analyzer";
    version = "0.4.1796";
    src = fetchurl {
      url = "https://rust-lang.gallery.vsassets.io/_apis/public/gallery/publisher/rust-lang/extension/rust-analyzer/0.4.1796/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "rust-analyzer-0.4.1796.zip";
      sha256 = "sha256-OMj6tlSqJH2NSpXxPSH0/pNpp7Yy+ce6TqMRHhqCVuM=";
    };
  };
  staticcheck = {
    pname = "staticcheck";
    version = "2023.1.6";
    src = fetchFromGitHub {
      owner = "dominikh";
      repo = "go-tools";
      rev = "2023.1.6";
      fetchSubmodules = false;
      sha256 = "sha256-Ecp3A3Go7mp8/ghMjTGqCNlRkCeEAb3fzRuwahWcM2I=";
    };
  };
  vue_volar = {
    pname = "vue_volar";
    version = "1.8.27";
    src = fetchurl {
      url = "https://vue.gallery.vsassets.io/_apis/public/gallery/publisher/vue/extension/volar/1.8.27/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "volar-1.8.27.zip";
      sha256 = "sha256-6FktlAJmOD3dQNn2TV83ROw41NXZ/MgquB0RFQqwwW0=";
    };
  };
}
