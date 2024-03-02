{ source, buildGoModule, lib }:

buildGoModule rec {
  inherit (source) pname version src;
  vendorHash = "sha256-Cat731ODnHIfbizDcOztmyIXOBSWPHT/0Pf4XuG+7TI=";

  doCheck = false;
  ldflags = [
    "-X main.version=${version}"
  ];

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
