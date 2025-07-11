{
  source,
  lib,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  inherit (source) pname version src;
  cargoLock.lockFile = ./Cargo.lock;
  useFetchCargoVendor = true;

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
    rm .cargo/config.toml
  '';

  meta = {
    description = "Rust backend for LibreSpeed";
    homepage = "https://github.com/librespeed/speedtest-rust";
    license = lib.licenses.lgpl3Only;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
  };
})
