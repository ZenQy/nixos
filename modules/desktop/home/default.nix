{ pkgs, lib }:

with builtins;

let
  conf = {
    vscode = {
      file = toFile "settings.json" (toJSON (import ./vscode.nix));
      path = ".config/VSCodium/User/settings.json";
      link = false;
    };
    niri = {
      file = toString ./niri-config.kdl;
      path = ".config/niri/config.kdl";
      link = true;
    };
  };
  ln = map
    (name:
      let
        symlink = "/home/nixos/" + conf.${name}.path;
        source = conf.${name}.file;
        target = substring 0 ((stringLength symlink) - (stringLength (baseNameOf symlink))) symlink;
        cmd = if conf.${name}.link then "ln -sf ${source} ${symlink}" else "cat ${source} > ${symlink}";
      in
      ''
        mkdir -p ${target}
        ${cmd}
      '')
    (attrNames conf);

  script = ''
    #!/usr/bin/env bash
  '' + concatStringsSep "\n" ln;

in
{
  gen = pkgs.writeScript "gen.sh" script;
}







