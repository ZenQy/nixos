{ pkgs, lib }:

with builtins;

let
  conf = {
    vscode = {
      file = toFile "settings.json" (toJSON (import ./vscode.nix));
      path = ".config/VSCodium/User/settings.json";
    };
    niri = {
      file = toString ./niri-config.kdl;
      path = ".config/niri/config.kdl";
    };
  };
  ln = map
    (name:
      let
        symlink = "/home/nixos/" + conf.${name}.path;
        source = conf.${name}.file;
        target = substring 0 ((stringLength symlink) - (stringLength (baseNameOf symlink))) symlink;
      in
      ''
        mkdir -p ${target}
        cp -f ${source} ${symlink}
        chmod +w ${symlink}
        # ln -sf ${source} ${symlink}
      '')
    (attrNames conf);

  script = ''
    #!/usr/bin/env bash
  '' + concatStringsSep "\n" ln;

in
{
  gen = pkgs.writeScript "gen.sh" script;
}







