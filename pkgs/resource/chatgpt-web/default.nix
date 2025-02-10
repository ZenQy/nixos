{
  source,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;

  installPhase = ''
    find . -name '*' -exec install -Dm644 {} "$out/share/chatgpt-web/{}" \;
  '';

  meta = with lib; {
    description = "Pure Javascript ChatGPT demo based on OpenAI API";
    homepage = "https://github.com/xqdoo00o/chatgpt-web";
    license = licenses.mit;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.all;
  };
}
