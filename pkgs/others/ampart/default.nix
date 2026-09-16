{
  source,
  stdenv,
  lib,
  zlib,
}:

stdenv.mkDerivation {
  inherit (source) pname version src;

  buildInputs = [
    zlib
  ];

  installPhase = ''
    install -Dm755 ampart $out/bin/ampart
  '';

  meta = with lib; {
    description = "A partition tool for Amlogic's proprietary emmc partition format";
    homepage = "https://github.com/7Ji/ampart";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
