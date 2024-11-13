{
  source,
  buildGo123Module,
  lib,
}:

buildGo123Module {
  inherit (source) pname version src;

  vendorHash = "sha256-1/U+sPauV3kYvQKTGSuX9FvvEFNsksTPXtfZH0a/o0s=";

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
