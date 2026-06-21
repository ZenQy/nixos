{ pkgs, ... }:

{

  programs.npm = {
    enable = true;
    npmrc = ''
      prefix = ''${HOME}/.config/npm
      registry=https://registry.npmmirror.com
      color=true
    '';
    package = pkgs.nodejs_latest;
  };
  environment.variables.PATH = "$HOME/.config/npm/bin";

  environment.systemPackages = with pkgs; [
    # eslint
    # oxlint
    vue-language-server
    # yarn
    vitejs
    # svelte-language-server
  ];

}
