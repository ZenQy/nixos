{ source, lib, vscode-utils }:

vscode-utils.buildVscodeMarketplaceExtension {
  vsix = source.src;
  mktplcRef = {
    name = "gitlens";
    publisher = "eamodio";
    version = source.version;
  };

  meta = with lib; {
    description = "Supercharge Git within VS Code";
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
