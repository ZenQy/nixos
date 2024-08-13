{ source, buildGoModule, lib }:

buildGoModule {
  inherit (source) pname version src;
  vendorHash = "sha256-OZ67BWsIUaU24BPQ1VjbGE4GkDZUKgbBG3ynUVXvyaU=";

  doCheck = false;
  subPackages = [ "cmd/staticcheck" ];

  meta = with lib; {
    description = "The advanced Go linter";
    homepage = "https://github.com/dominikh/go-tools";
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
