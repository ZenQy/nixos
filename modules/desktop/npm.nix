{ ... }:

{

  programs.npm = {
    enable = true;
    npmrc = ''
      prefix = ''${HOME}/.config/npm
      color=true
    '';
  };
  environment.variables.PATH = "$HOME/.npm/bin";

}
