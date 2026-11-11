{
  source,
  lib,
  buildGoModule,
}:

buildGoModule (finalAttrs: {
  inherit (source) pname version src;

  proxyVendor = true;
  vendorHash = null;

  doCheck = false;

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = [ "cmd/mcis" ];

  postInstall = ''
    find . -type f -name "*.txt" -exec install -Dm644 {} "$out/share/{}" \;
  '';
  meta = {
    description = "一个 Cloudflare IP 优选工具：用蒙特卡洛搜索算法，在更少探测次数下，从 IPv4/IPv6 网段里找到更快、更稳定的 IP。";
    homepage = "https://github.com/Leo-Mu/montecarlo-ip-searcher";
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
