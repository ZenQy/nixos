# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  bingimg = {
    pname = "bingimg";
    version = "SpaceFlight_EN-US8143075629";
    src = fetchurl {
      url = "https://www.bing.com/th?id=OHR.SpaceFlight_EN-US8143075629_UHD.jpg";
      sha256 = "sha256-Rsko3SY//HflBVOAsjr8UdNVjFGOBn2zGKx5LQ6HL0w=";
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
  fcitx5-pinyin-zenith = {
    pname = "fcitx5-pinyin-zenith";
    version = "v2025.04.02";
    src = fetchurl {
      url = "https://github.com/ZenQy/scel2dict/releases/download/v2025.04.02/zenith.dict";
      sha256 = "sha256-dqhv1Ei/2YGBAJBtYQDhkoDR2/esA7VhCCqz0qeZPwg=";
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
  vitejs = {
    pname = "vitejs";
    version = "v6.2.6";
    src = fetchFromGitHub {
      owner = "vitejs";
      repo = "vite";
      rev = "v6.2.6";
      fetchSubmodules = false;
      sha256 = "sha256-tbrUxtc/aq6UT5E5eZBD1L8F80iq+rQm/ai5HsQVtB0=";
    };
  };
  wallpapers = {
    pname = "wallpapers";
    version = "v2025.04.03";
    src = fetchurl {
      url = "https://github.com/ZenQy/wallpaper/releases/download/v2025.04.03/wallpaper.tar.gz";
      sha256 = "sha256-H78UhFPHN/PN1YQ5UkOUUe+vXQYY27GwxozVS1N3MEg=";
    };
  };
}
