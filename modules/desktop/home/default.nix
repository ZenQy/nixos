{ pkgs, lib }:

with builtins;

let
  conf = {
    vscode = {
      file = toFile "settings.json" (toJSON (import ./vscode.nix));
      path = ".config/VSCodium/User/settings.json";
    };
    zed = {
      file = toFile "settings.json" (toJSON (import ./zed.nix));
      path = ".config/zed/settings.json";
    };
    go = {
      file = toFile "go.env" ''
        GO111MODULE=on
        GOPROXY=https://goproxy.cn,direct
        CGO_ENABLED=0
      '';
      path = ".config/go/env";
    };
    # niri = {
    #   file = toString ./niri-config.kdl;
    #   path = ".config/niri/config.kdl";
    # };
  };
  cmd = map (
    name:
    let
      fullpath = "/home/nixos/" + conf.${name}.path;
      source = conf.${name}.file;
      target = substring 0 ((stringLength fullpath) - (stringLength (baseNameOf fullpath))) fullpath;
      ext = concatStringsSep "" (match ".*\\.(.+?$)" fullpath);
    in
    ''
      mkdir -p ${target}
      ${if ext == "json" then pkgs.jq + "/bin/jq ." else "cat"} ${source} > ${fullpath}
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
