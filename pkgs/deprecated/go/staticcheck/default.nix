{
  source,
  buildGoModule,
  lib,
}:

buildGoModule {
  inherit (source) pname version src;
  vendorHash = "sha256-HssfBnSKdVZVgf4f0mwsGTwhiszBlE2HmDy7cvyvJ60=";

  doCheck = false;
  subPackages = [ "cmd/staticcheck" ];

  meta = with lib; {
    description = "The advanced Go linter";
    homepage = "https://github.com/dominikh/go-tools";
    license = licenses.mit;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
