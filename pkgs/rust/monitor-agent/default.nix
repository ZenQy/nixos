{
  source,
  lib,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  inherit (source) pname version src;
  cargoLock.lockFile = source.extract."Cargo.lock";

  doCheck = false;

  meta = {
    description = "Linux monitoring agent for the monitor hub";
    homepage = "https://github.com/monitor-probe/agent";
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
