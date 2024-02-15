{ source, lib, buildGo121Module, fetchgit, fetchurl, fetchFromGitHub, dockerTools, }:
with builtins;

let
  sources = (import ../../_sources/generated.nix) {
    inherit fetchgit fetchurl fetchFromGitHub dockerTools;
  };
  alist-dist = sources.alist-dist;
in

buildGo121Module rec {
  inherit (source) pname version src;

  postUnpack = ''
    cp -rf ${alist-dist.src}/dist/ source/public
  '';

  postPatch = ''
    sed -i "s|BuiltAt    string|BuiltAt    string = \"$(date +'%F %T %z')\"|g" internal/conf/var.go
    GoVersion=$(go version | sed 's/go version //')
    sed -i "s|GoVersion  string|GoVersion  string = \"$GoVersion\"|g" internal/conf/var.go
    sed -i "s|GitAuthor  string|GitAuthor  string = \"alist-org\"|g" internal/conf/var.go
    sed -i "s|GitCommit  string|GitCommit  string = \"${version}\"|g" internal/conf/var.go
    sed -i "s|dev|${version}|g" internal/conf/var.go
    sed -i "s|WebVersion string|WebVersion string = \"${alist-dist.version}\"|g" internal/conf/var.go
  '';

  vendorHash = "sha256-kMhp1FpiSmZQH5i2EbmzXusqTG9mfR9m+/9Gbq+p/u0=";

  doCheck = false;
  subPackages = [ "./" ];

  meta = with lib; {
    description = "A file list/WebDAV program that supports multiple storages, powered by Gin and Solidjs.";
    homepage = "https://github.com/alist-org/alist";
    license = lib.licenses.agpl3;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
