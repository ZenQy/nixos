{
  source,
  buildGoModule,
  lib,
}:

buildGoModule {
  inherit (source) pname version src;
  vendorHash = "sha256-SYefkgc0CsAEdkL7rxu9fpz7dpBnx1LwabIadUeOKco=";

  doCheck = false;

  subPackages = [ "cmd/dashboard" ];
  patches = [ ./main.patch ];

  postInstall = ''
    mv $out/bin/dashboard $out/bin/nezha-dashboard
  '';

  meta = with lib; {
    description = "一站式轻监控轻运维系统";
    homepage = "https://github.com/naiba/nezha";
    license = lib.licenses.asl20;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
