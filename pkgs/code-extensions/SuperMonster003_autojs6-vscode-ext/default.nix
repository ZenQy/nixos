{
  source,
  lib,
  vscode-utils,
}:

with builtins;

vscode-utils.buildVscodeMarketplaceExtension {
  vsix = source.src;
  mktplcRef = {
    publisher = "SuperMonster003";
    name = "autojs6-vscode-ext";
    version = source.version;
  };

  meta = with lib; {
    license = licenses.gpl3;
    maintainers = [
      {
        name = "ZenQy";
        email = "zenqy.qin@gmail.com";
      }
    ];
    platforms = platforms.linux;
  };
}
