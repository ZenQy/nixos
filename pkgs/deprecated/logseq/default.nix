{ source, lib, stdenv, unzip, makeWrapper, electron }:

stdenv.mkDerivation rec {
  inherit (source) pname version src;

  nativeBuildInputs = [ makeWrapper unzip ];
  installPhase = ''
    mkdir -p $out/share/${pname}
    cp -a resources $out/share/${pname}
    install -Dm644 Logseq $out/bin/${pname}
    install -Dm644 ${./logseq.desktop} $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace Icon=logseq Icon=$out/share/${pname}/resources/app/icons/logseq.png

    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags $out/share/${pname}/resources/app
  '';

  meta = with lib; {
    description = "A privacy-first, open-source platform for knowledge management and collaboration";
    homepage = "https://github.com/logseq/logseq";
    license = licenses.agpl3Plus;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = [ "x86_64-linux" ];
  };
}
