{
  source,
  lib,
  buildGo126Module,
  komari-web,
}:

buildGo126Module (finalAttrs: {
  inherit (source) pname version src;

  proxyVendor = true;
  vendorHash = "sha256-z23ljJGt2kUQmGZrHNAFtStFYgcGOsIsuQYaXjUKupw=";

  preConfigure = ''
    cp -r ${komari-web} public/defaultTheme
    ls public/defaultTheme
  '';

  env.CGO_ENABLED = 1;

  doCheck = false;

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/komari-monitor/komari/utils.CurrentVersion=${finalAttrs.version}"
    "-X=github.com/komari-monitor/komari/utils.VersionHash=${finalAttrs.vendorHash}"
  ];

  meta = {
    description = "A simple server monitor tool.";
    homepage = "https://github.com/komari-monitor/komari";
    license = lib.licenses.mit;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = lib.platforms.linux;
  };
})
