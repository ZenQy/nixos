{ source, buildGoModule, lib }:

buildGoModule {
  inherit (source) pname version src;
  vendorHash = "sha256-wM+mh+gFduatQeqbQMtqm05/NodnfqaupPHRtjWVtV4=";

  doCheck = false;
  subPackages = [ "cmd" ];

  patches = [ ./main.patch ];
  postPatch = ''
    sed -i "s|leetcode-cn.com|leetcode.cn|g" pkg/leetcode/leetcode.go
  '';
  postInstall = ''
    mv $out/bin/cmd $out/bin/leetcode-tool
  '';

  meta = with lib; {
    description = "一个让你更方便刷题的工具";
    homepage = "https://github.com/zcong1993/leetcode-tool";
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
