{
  source,
  lib,
  buildGoModule,
  stdenv,
}:
buildGoModule {
  inherit (source) pname version src;

  vendorHash = "sha256-ed5gZe1DxV59rpBjZa6JTs4A99JWPTQvO1gr6rqWzPc=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/nezhahq/agent/pkg/monitor.Version=${source.version}"
    "-X main.arch=${stdenv.hostPlatform.system}"
  ];

  doCheck = false;
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
