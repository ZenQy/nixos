{ source, buildGo122Module, lib }:

buildGo122Module {
  inherit (source) pname version src;

  vendorHash = "sha256-zpS+6Z31m6g67we4JaQ0sPodqC315lgftqGzZkelDCU=";

  doCheck = false;
  subPackages = [ "./" ];

  meta = with lib; {
    description = "Best LeetCode friend for geek.";
    homepage = "https://github.com/j178/leetgo";
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
