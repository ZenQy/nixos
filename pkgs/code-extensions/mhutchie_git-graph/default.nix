{ source, lib, vscode-utils }:

vscode-utils.buildVscodeMarketplaceExtension {
  vsix = source.src;
  mktplcRef = {
    name = "mhutchie";
    publisher = "git-graph";
    version = source.version;
  };

  meta = with lib; {
    description = "View a Git Graph of your repository, and perform Git actions from the graph.";
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
