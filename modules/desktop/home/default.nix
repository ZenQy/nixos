{ pkgs }:

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
  cmd = map (
    name:
    let
      fullpath = "/home/nixos/" + conf.${name}.path;
      source = conf.${name}.file;
      target = substring 0 ((stringLength fullpath) - (stringLength (baseNameOf fullpath))) fullpath;
    in
    ''
      mkdir -p ${target}
      cat ${source} > ${fullpath}
    ''
  ) (attrNames conf);

  script =
    ''
      #!/usr/bin/env bash
    ''
    + concatStringsSep "\n" cmd;

in
{
  gen = pkgs.writeScript "gen.sh" script;
}
