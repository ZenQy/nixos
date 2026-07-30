{
  source,
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  inherit (source) pname version src;

  proxyVendor = true;
  vendorHash = "";

  doCheck = false;

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "./cmd/yx" ];

  meta = {
    description = "Cloudflare 优选 IP 测速工具。单个二进制，命令行和网页界面都能用。";
    homepage = "https://github.com/byJoey/yx-tools";
    license = lib.licenses.gpl3Only;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = lib.platforms.linux;
  };
})
