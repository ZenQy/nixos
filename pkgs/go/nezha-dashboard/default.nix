{
  source,
  buildGoModule,
  lib,
  geoip,
}:

buildGoModule {
  inherit (source) pname version src;
  vendorHash = "sha256-IMS9o9f/65r4RClg1/0gAb/zbXvky8NTYrhOfXeDXEo=";

  doCheck = false;
  subPackages = [ "cmd/dashboard" ];

  postPatch = ''
    cp -f ${geoip}/geoip.db pkg/geoip
    chmod +w pkg/geoip/geoip.db

    sed -i "s|data/config|/etc/nezha/dashboard|g" cmd/dashboard/main.go
    sed -i "s|data/sqlite|/etc/nezha/dashboard|g" cmd/dashboard/main.go
  '';

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
