{
  source,
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  inherit (source) pname version src;

  installPhase = ''
    find . -type f -name "*.txt" -exec install -Dm644 {} "$out/share/${source.pname}/{}" \;
  '';

  meta = with lib; {
    description = "Updated daily! A list of popular BitTorrent Trackers";
    homepage = "https://github.com/XIU2/TrackersListCollection";
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
})
