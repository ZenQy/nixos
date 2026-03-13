{
  source,
  lib,
  buildGo126Module,
  Ech0-frontend,
}:

buildGo126Module (finalAttrs: {
  inherit (source) pname version src;

  proxyVendor = true;
  vendorHash = "sha256-F56KvpG9i8vcsZx73LZXRdmkN8K4Kz18T6P27gbD8Vg=";

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
