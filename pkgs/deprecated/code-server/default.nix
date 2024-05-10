{ source, lib, stdenv, nodejs, makeWrapper }:

stdenv.mkDerivation rec {
  inherit (source) pname version src;

  nativeBuildInputs = [ nodejs makeWrapper ];

  installPhase = ''
    mkdir -p $out/libexec/${pname} $out/bin
    rm -rf bin
    cp -a * $out/libexec/${pname}

    makeWrapper "${nodejs}/bin/node" "$out/bin/${pname}" \
      --add-flags "$out/libexec/${pname}/out/node/entry.js"
  '';

  meta = with lib; {
    description = "Run VS Code on a remote server";
    homepage = "https://github.com/coder/code-server";
    license = licenses.mit;
    maintainers = [{
      name = "ZenQy";
      email = "zenqy.qin@gmail.com";
    }];
    mainProgram = "code-server";
    platforms = [ "aarch64-linux" ];
  };
}
