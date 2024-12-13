{
  source,
  buildGoModule,
  lib,
}:

buildGoModule {
  inherit (source) pname version src;
  vendorHash = "sha256-hQpZ1pINepCfefV0b8rhly63zfJWfNP29bwkm19pAq0=";

  postPatch = ''
    find * | grep -v client-go | xargs rm -rf
    mv client-go/* ./
    rm -rf client-go
  '';

  doCheck = false;

  meta = with lib; {
    description = "Client for Firelookout Server NG | HPFS server monitor";
    homepage = "https://github.com/kwaitsing/Artemis";
    license = licenses.bsd3;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
