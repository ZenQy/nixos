{ source, lib, vscode-utils }:

vscode-utils.buildVscodeMarketplaceExtension {
  vsix = source.src;
  mktplcRef = {
    name = "go";
    publisher = "golang";
    version = source.version;
  };

  meta = with lib; {
    description = "Rich Go language support for Visual Studio Code.";
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
