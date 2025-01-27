{
  source,
  lib,
  buildGoModule,
  alist-web,
}:

buildGoModule rec {
  inherit (source) pname version src;

  postPatch = ''
    cp -r ${alist-web}/* public/dist
    sed -i "s|BuiltAt    string|BuiltAt    string = \"$(date +'%F %T %z')\"|g" internal/conf/var.go
    GoVersion=$(go version | sed 's/go version //')
    sed -i "s|GoVersion  string|GoVersion  string = \"$GoVersion\"|g" internal/conf/var.go
    sed -i "s|GitAuthor  string|GitAuthor  string = \"alist-org\"|g" internal/conf/var.go
    sed -i "s|GitCommit  string|GitCommit  string = \"${version}\"|g" internal/conf/var.go
    sed -i "s|dev|${version}|g" internal/conf/var.go
    sed -i "s|WebVersion string|WebVersion string = \"${alist-web.version}\"|g" internal/conf/var.go
  '';

  vendorHash = "sha256-HhJYp9yIHwhV5kjqeGLWbb+lGp7Sh2bq8DNWRwSx2Bg=";

  doCheck = false;
  subPackages = [ "./" ];

  meta = with lib; {
    description = "A file list/WebDAV program that supports multiple storages, powered by Gin and Solidjs.";
    homepage = "https://github.com/alist-org/alist";
    license = lib.licenses.agpl3Only;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
