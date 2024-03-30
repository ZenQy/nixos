{ source, buildGoModule, lib }:

buildGoModule {
  inherit (source) pname version src;
  vendorHash = "sha256-DTMGy4urBJmPBu96NyZHIKBcl+rpsxSbbpwo4sAneyA=";

  doCheck = false;
  subPackages = [ "cmd/dashboard" ];

  postPatch = ''
    sed -i "s|data/config|/etc/nezha/dashboard|g" cmd/dashboard/main.go
    sed -i "s|data/sqlite|/etc/nezha/dashboard|g" cmd/dashboard/main.go
    sed -i "s|resource/|$out/share/resource/|g" cmd/dashboard/controller/controller.go
    sed -i "s|resource/|$out/share/resource/|g" service/singleton/l10n.go
  '';

  postInstall = ''
    mv $out/bin/dashboard $out/bin/nezha-dashboard
    mkdir $out/share
    cp -r $src/resource $out/share
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
