{ source, pkgs, lib, buildNpmPackage }:

buildNpmPackage {
  inherit (source) pname version src;

  npmDepsHash = "sha256-Yy/SjJkMn+gRDlswnuuIcz8nMJnwJ3w1j4N8mIE6hCM=";

  nativeBuildInputs = [
    pkgs.python3
  ];

  npmBuildScript = "start";
  postPatch = ''
    sed -i "s|cd dist|mkdir \$out|g" package.json
    sed -i "s|npm start|cp -r * \$out|g" package.json
  '';
  # The prepack script runs the build script, which we'd rather do in the build phase.
  # npmPackFlags = [ "--ignore-scripts" ];
  NODE_OPTIONS = "--openssl-legacy-provider";

  postInstall = ''
  '';

  meta = with lib; {
    description = "Web client prototype for scrcpy.";
    homepage = "https://github.com/NetrisTV/ws-scrcpy";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
