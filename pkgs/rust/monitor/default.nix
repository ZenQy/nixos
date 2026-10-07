{
  source,
  lib,
  rustPlatform,
  monitor-web-admin,
  monitor-theme-default,
}:

rustPlatform.buildRustPackage {
  inherit (source) pname version src;
  cargoLock.lockFile = source.extract."Cargo.lock";

  preBuild = ''
    cp -r ${monitor-web-admin} web-admin/dist
    mkdir target
    cp -r ${monitor-theme-default} target/theme

    echo "#!/bin/sh" > scripts/theme.sh
    echo "exit 0" >> scripts/theme.sh
    chmod +x scripts/theme.sh
  '';

  doCheck = false;

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
}
