{
  source,
  lib,
  buildGoModule,
  Ech0-web,
}:

buildGoModule (finalAttrs: {
  inherit (source) pname version src;

  proxyVendor = true;
  vendorHash = "sha256-D/p/1MV41xoGEjZ1LlT6sLZeyC1zF2rrZXhWcMjwuiI=";

  preConfigure = ''
    rm -rf template/dist
    cp -r ${Ech0-web} template/dist

    mkdir -p /tmp/include
    cp ${./sqlite3.h} /tmp/include/sqlite3.h
  '';

  env.CGO_ENABLED = 1;
  env.C_INCLUDE_PATH = "/tmp/include";

  subPackages = [ "./cmd/ech0" ];

  tags = [ "netgo" ];

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/lin-snow/ech0/internal/version.Commit=${finalAttrs.version}"
  ];

  meta = {
    description = "Ech0 - 开源、自托管、专注思想流动的轻量级发布平台";
    homepage = "https://github.com/lin-snow/Ech0";
    license = lib.licenses.agpl3Only;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = lib.platforms.linux;
  };
})
