{
  source,
  lib,
  buildNpmPackage,
}:

buildNpmPackage (finalAttrs: {
  inherit (source) pname version src;

  sourceRoot = "${finalAttrs.src.name}/web-admin";

  npmDepsHash = "sha256-Azlx8TtHajpVdwcPdYhX75xFuIut4trGLKxxVnAbImY=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  NODE_OPTIONS = "--openssl-legacy-provider";

  installPhase = ''
    cp -r dist $out
  '';

  meta = {
    description = "用 Rust 写的轻量级服务器探针 (Rust + axum + SQLite)";
    homepage = "https://github.com/monitor-probe/monitor";
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
