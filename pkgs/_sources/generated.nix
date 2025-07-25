# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  fcitx5-pinyin-zenith = {
    pname = "fcitx5-pinyin-zenith";
    version = "v2025.07.02";
    src = fetchurl {
      url = "https://github.com/ZenQy/scel2dict/releases/download/v2025.07.02/zenith.dict";
      sha256 = "sha256-ENHihUfpbo6o84BdBo3LUWxOIkwQ/xnMosywaRKvfWY=";
    };
  };
  librespeed-rs = {
    pname = "librespeed-rs";
    version = "v1.3.8";
    src = fetchFromGitHub {
      owner = "librespeed";
      repo = "speedtest-rust";
      rev = "v1.3.8";
      fetchSubmodules = false;
      sha256 = "sha256-TINIKZefT4ngnEtlMjxO56PrQxW5gyb1+higiSnkE3Q=";
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
  linux-flippy = {
    pname = "linux-flippy";
    version = "fbbb69804f8fd1993e920a191088bff605861b67";
    src = fetchFromGitHub {
      owner = "unifreq";
      repo = "linux-6.12.y";
      rev = "fbbb69804f8fd1993e920a191088bff605861b67";
      fetchSubmodules = false;
      sha256 = "sha256-bDrSOewwV/3d2RCZnFop8jTZmAFXRxaVob1VXRV4mVU=";
    };
    date = "2025-07-21";
  };
  vitejs = {
    pname = "vitejs";
    version = "v7.0.6";
    src = fetchFromGitHub {
      owner = "vitejs";
      repo = "vite";
      rev = "v7.0.6";
      fetchSubmodules = false;
      sha256 = "sha256-/cJzxcgUCWB1AfJWA3oantuI1n1hNNKLsHrgXLkAG3o=";
    };
  };
  wallpapers = {
    pname = "wallpapers";
    version = "v2025.07.03";
    src = fetchurl {
      url = "https://github.com/ZenQy/wallpaper/releases/download/v2025.07.03/wallpaper.tar.gz";
      sha256 = "sha256-7awBsTJfE76bdYAPANB+Ccg2z8R22UahebQ0Y46CK9M=";
    };
  };
}
