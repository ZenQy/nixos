{
  source,
  stdenvNoCC,
  lib,
  imagemagick,
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname version src;
  nativeBuildInputs = [ imagemagick ];
  installPhase = ''
    # Create output directories
    mkdir -p $out/share/image $out/share/image-blur

    # Install all jpg files preserving directory structure
    find . -type f -name "*.jpg" -exec install -Dm644 {} "$out/share/image/{}" \;

    # Create a blurred version from the first jpg file
    first_jpg=$(find . -type f -name "*.jpg" -print -quit)
    if [ -n "$first_jpg" ]; then
      convert -blur 16x9 "$first_jpg" "$out/share/image-blur/swaylock.jpg"
    else
      echo "Warning: No jpg files found for creating blurred image"
    fi
  '';

  meta = with lib; {
    description = "必应壁纸";
    homepage = "https://github.com/ZenQy/wallpaper";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
