{ source, buildGoModule, lib }:

buildGoModule {
  inherit (source) pname version src;

  vendorHash = "sha256-GWsq02XszYwa8jzsFCayQW/vvYfBN7F8+L50srH9s4g=";

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
