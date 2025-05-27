{
  source,
  buildGoModule,
  lib,
}:

buildGoModule {
  inherit (source) pname version src;
  vendorHash = "18al983k8xqmdz5lsp32s7m1gxrha427y56dffa6fxs9fx4jv1ld";

  doCheck = false;

  meta = with lib; {
    description = "Utility to extract JSON representation of declarations from a Go source file";
    homepage = "https://github.com/ramya-rao-a/go-outline";
    license = lib.licenses.mit;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
