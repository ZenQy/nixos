{ source, lib, vscode-utils }:

vscode-utils.buildVscodeMarketplaceExtension {
  vsix = source.src;
  mktplcRef = {
    name = "material-icon-theme";
    publisher = "pkief";
    version = source.version;
  };

  meta = with lib; {
    description = "Material Design Icons for Visual Studio Code.";
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
