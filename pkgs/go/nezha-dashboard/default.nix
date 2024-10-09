{ source, buildGoModule, lib }:

buildGoModule {
  inherit (source) pname version src;
  vendorHash = "sha256-mBE2Ik+rFXJPXmTEq6bNkJZo9RDwvD+L++F4z+A7NQ4=";

  doCheck = false;
  subPackages = [ "cmd/dashboard" ];

  postPatch = ''
    sed -i "s|data/config|/etc/nezha/dashboard|g" cmd/dashboard/main.go
    sed -i "s|data/sqlite|/etc/nezha/dashboard|g" cmd/dashboard/main.go
    # sed -i "s|resource/|$out/share/resource/|g" cmd/dashboard/controller/controller.go
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
