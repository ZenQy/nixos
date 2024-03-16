{ source, buildGo122Module, lib }:

buildGo122Module {
  inherit (source) pname version src;

  vendorHash = "sha256-fDTsqkQVeQNwH8Qt50Nqe9cABrKGkxfshd5S0gKqOhg=";

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
