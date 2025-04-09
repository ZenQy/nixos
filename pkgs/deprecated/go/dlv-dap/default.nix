{
  source,
  buildGoModule,
  lib,
}:

buildGoModule {
  inherit (source) pname version src;

  vendorHash = null;

  doCheck = false;
  subPackages = [ "cmd/dlv" ];
  postInstall = ''
    cp $out/bin/dlv $out/bin/dlv-dap
  '';

  meta = with lib; {
    description = "debugger for the Go programming language";
    homepage = "https://github.com/go-delve/delve";
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
