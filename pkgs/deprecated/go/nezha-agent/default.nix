{
  source,
  lib,
  buildGoModule,
  stdenv,
}:
buildGoModule {
  inherit (source) pname version src;

  vendorHash = "sha256-g7F/kkA9BXJj8oTFt0IrvloOyGNIE//tQg+ND7aJokg=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/nezhahq/agent/pkg/monitor.Version=${source.version}"
    "-X main.arch=${stdenv.hostPlatform.system}"
  ];
  doCheck = false;
  preBuild = "go generate ./...";
  postInstall = ''
    mv $out/bin/agent $out/bin/nezha-agent
  '';

  meta = with lib; {
    description = "Agent of Nezha Monitoring";
    homepage = "https://github.com/nezhahq/agent";
    license = lib.licenses.asl20;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
