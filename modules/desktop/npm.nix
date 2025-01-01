{ pkgs, ... }:

{

  programs.npm = {
    enable = true;
    package = pkgs.nodePackages_latest.npm;
    npmrc = ''
      prefix = ''${HOME}/.config/npm
      registry=https://registry.npmmirror.com
      color=true
    '';
  };
  environment.variables.PATH = "$HOME/.config/npm/bin";

  environment.systemPackages = with pkgs; [
    nodePackages_latest.nodejs
    # nodePackages.eslint
    # oxlint
    # vue-language-server
    # yarn
    vitejs
    svelte-language-server
  ];

}
