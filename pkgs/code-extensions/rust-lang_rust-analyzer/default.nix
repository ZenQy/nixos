{ source, lib, vscode-utils }:

vscode-utils.buildVscodeMarketplaceExtension {
  vsix = source.src;
  mktplcRef = {
    name = "rust-analyzer";
    publisher = "rust-lang";
    version = source.version;
  };

  meta = with lib; {
    description = "This extension provides support for the Rust programming language. It is recommended over and replaces rust-lang.rust.";
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
