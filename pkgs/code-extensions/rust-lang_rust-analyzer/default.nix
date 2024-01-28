{ source, lib, vscode-utils }:

with builtins;

vscode-utils.buildVscodeMarketplaceExtension {
  vsix = source.src;
  mktplcRef =
    let
      list = match "(.*?)_(.*?)" source.pname;
    in
    {
      publisher = head list;
      name = head (tail list);
      version = source.version;
    };

  meta = with lib; {
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
