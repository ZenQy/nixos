{
  source,
  lib,
  buildGo123Module,
  go-swag,
  dbip-country-lite,
  formats,
  nezha-theme-admin,
  nezha-theme-user,
  withThemes ? [ ],
}:

let

  fontendName = lib.removePrefix "nezha-theme-";

  frontend-templates =
    let
      mkTemplate = theme: {
        path = "${fontendName theme.pname}-dist";
        name = fontendName theme.pname;
        repository = theme.meta.homepage;
        author = theme.src.owner;
        version = theme.version;
        isofficial = false;
        isadmin = false;
      };
    in
    (formats.yaml { }).generate "frontend-templates.yaml" (
      [
        (
          mkTemplate nezha-theme-admin
          // {
            name = "OfficialAdmin";
            isadmin = true;
            isofficial = true;
          }
        )
        (
          mkTemplate nezha-theme-user
          // {
            name = "Official";
            isofficial = true;
          }
        )
      ]
      ++ map mkTemplate withThemes
    );

in

buildGo123Module {
  inherit (source) pname version src;

  proxyVendor = true;

  prePatch =
    ''
      rm -rf cmd/dashboard/*-dist

      cp ${frontend-templates} service/singleton/frontend-templates.yaml
    ''
    + lib.concatStringsSep "\n" (
      map (theme: "cp -r ${theme} cmd/dashboard/${fontendName theme.pname}-dist") (
        [
          nezha-theme-admin
          nezha-theme-user
        ]
        ++ withThemes
      )
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

  vendorHash = "sha256-BeSE+gn1NCeSlfrPFEvq8GLm1AQn18av5jfQQ26XNZQ=";

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
