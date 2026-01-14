{ pkgs, ... }:

let
  inherit (builtins)
    attrNames
    concatStringsSep
    match
    stringLength
    substring
    toFile
    toJSON
    ;

  homeDir = "/home/nixos";

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
  };

  mkCommand =
    name:
    let
      config = conf.${name};
      fullPath = "${homeDir}/${config.path}";
      targetDir = substring 0 (stringLength fullPath - stringLength (baseNameOf fullPath)) fullPath;
      extension = concatStringsSep "" (match ".*\\.(.+)$" fullPath);
      command = if extension == "json" then "${pkgs.jq}/bin/jq ." else "cat";
    in
    ''
      mkdir -p ${targetDir}
      ${command} ${config.file} > ${fullPath}
    '';

  commands = map mkCommand (attrNames conf);

  script = ''
    #!/usr/bin/env bash
    ${concatStringsSep "\n" commands}
  '';

in
{
  gen = pkgs.writeScript "gen.sh" script;
}
