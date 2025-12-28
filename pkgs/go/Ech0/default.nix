{
  source,
  lib,
  buildGoModule,
  Ech0-frontend,
}:

buildGoModule (finalAttrs: {
  inherit (source) pname version src;

  proxyVendor = true;
  vendorHash = "sha256-y5xtJC9KrVYOW0fpn0fveUfL2draEkrHdIUjdMHofvE=";

  preConfigure = ''
    rm -rf template/dist
    cp -r ${Ech0-frontend} template/dist
  '';

  env.CGO_ENABLED = 1;

  subPackages = [ "./" ];

  tags = [ "netgo" ];

  ldflags = [
    "-s"
    "-w"
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
