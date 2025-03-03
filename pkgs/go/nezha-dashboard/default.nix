{
  source,
  lib,
  buildGo124Module,
  go-swag,
  dbip-country-lite,
  formats,
  nezha-theme-admin,
  nezha-theme-nazhua,
}:

let

  fontendName = lib.removePrefix "nezha-theme-";

  frontend-templates =
    let
      mkTemplate = theme: {
        path = "${fontendName theme.pname}-dist";
        name = fontendName theme.pname;
        repository = theme.meta.homepage;
        version = theme.version;
        isofficial = true;
      };
    in
    (formats.yaml { }).generate "frontend-templates.yaml" [
      (
        mkTemplate nezha-theme-admin
        // {
          name = "OfficialAdmin";
          author = "nezhahq";
          isadmin = true;
        }
      )
      (
        mkTemplate nezha-theme-nazhua
        // {
          author = "hi2shark";
          isadmin = false;
          isofficial = false;
        }
      )
    ];

in

buildGo124Module {
  inherit (source) pname version src;

  proxyVendor = true;

  prePatch =
    ''
      rm -rf cmd/dashboard/*-dist

      cp ${frontend-templates} service/singleton/frontend-templates.yaml
    ''
    + lib.concatStringsSep "\n" (
      map (theme: "cp -r ${theme} cmd/dashboard/${fontendName theme.pname}-dist") [
        nezha-theme-admin
        nezha-theme-nazhua
      ]
    );

  patches = [
    # Nezha originally used ipinfo.mmdb to provide geoip query feature.
    # Unfortunately, ipinfo.mmdb must be downloaded with token.
    # Therefore, we patch the nezha to use dbip-country-lite.mmdb in nixpkgs.
    ./dbip.patch
  ];

  postPatch = ''
    cp ${dbip-country-lite.mmdb} pkg/geoip/geoip.db
  '';

  nativeBuildInputs = [ go-swag ];

  # Generate code for Swagger documentation endpoints (see cmd/dashboard/docs).
  preBuild = ''
    GOROOT=''${GOROOT-$(go env GOROOT)} swag init --pd -d . -g ./cmd/dashboard/main.go -o ./cmd/dashboard/docs --parseGoList=false
  '';

  vendorHash = "sha256-X3cq86wpyT0JrMFa3JfeN6xM4QhLcdbkkWr+66nHM5U=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/nezhahq/nezha/service/singleton.Version=${source.version}"
  ];

  doCheck = false;

  postInstall = ''
    mv $out/bin/dashboard $out/bin/nezha-dashboard
  '';

  meta = with lib; {
    description = "Self-hosted, lightweight server and website monitoring and O&M tool";
    homepage = "https://github.com/nezhahq/nezha";
    changelog = "https://github.com/nezhahq/nezha/releases/tag/v${source.version}";
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
