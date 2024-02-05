{ source, buildGoModule, lib }:

buildGoModule {
  inherit (source) pname version src;

  vendorHash = "sha256-GG9IfM50uVhsQVjXhUrYxuEbPlbsEsFubmUUSMr5SD4=";

  doCheck = false;
  subPackages = [ "./." ];

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
