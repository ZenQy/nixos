{ source, lib, mkYarnPackage }:

mkYarnPackage {
  inherit (source) pname version src;

  distPhase = "true";

  buildPhase = ''
    echo "module.exports = {};" > postcss.config.js
    export NODE_OPTIONS=--openssl-legacy-provider
    export HOME=$(mktemp -d)
    cd deps/markdown-online-editor
    yarn --offline build
  '';

  installPhase = ''
    cp -r dist $out
  '';

  meta = with lib; {
    description = "基于 Vue、Vditor，所构建的在线 Markdown 编辑器";
    homepage = "https://github.com/nicejade/markdown-online-editor";
    license = lib.licenses.mit;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.all;
  };
}
