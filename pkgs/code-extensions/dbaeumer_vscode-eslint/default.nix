{ source, lib, vscode-utils }:

vscode-utils.buildVscodeMarketplaceExtension {
  vsix = source.src;
  mktplcRef = {
    name = "vscode-eslint";
    publisher = "dbaeumer";
    version = source.version;
  };

  meta = with lib; {
    description = "Integrates ESLint JavaScript into VS Code.";
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
