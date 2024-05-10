{ source, lib, buildNpmPackage, python3, makeWrapper, nodejs, android-tools }:

buildNpmPackage rec {
  inherit (source) pname version src;

  npmDepsHash = "sha256-6D3bk+P1+A+6XIZ1D3qvHalC18Ti9yHvaNPnBzZgB7c=";

  nativeBuildInputs = [
    python3
    makeWrapper
  ];

  buildInputs = [
    nodejs
    android-tools
  ];

  npmBuildScript = "dist";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  # npmPackFlags = [ "--ignore-scripts" ];
  NODE_OPTIONS = "--openssl-legacy-provider";

  postPatch = ''
    # dabh/colors 更名为 colors/colors,所以 package-lock.json 中应进行相应更改
    sed -i 's|dabh/colors|colors/colors|g' package-lock.json
  '';

  installPhase = ''
    mkdir -p $out/{bin,lib}
    cp -r dist/* $out/lib
    cp -r node_modules $out

    makeWrapper ${nodejs}/bin/node $out/bin/${pname} \
      --add-flags "$out/lib/index.js"
  '';

  meta = with lib; {
    description = "Web client prototype for scrcpy.";
    homepage = "https://github.com/NetrisTV/ws-scrcpy";
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
