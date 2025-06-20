with builtins;
let
  floder =
    dir:
    filter (v: v != null) (
      attrValues (
        mapAttrs (k: v: if k != "deprecated" && k != "_sources" && v == "directory" then k else null) (
          readDir dir
        )
      )
    );

  # 缓存根目录列表，避免多次计算
  rootDirs = floder ./.;

  packageLists = concatMap (dir: map (subdir: "${dir}/${subdir}") (floder ./${dir})) rootDirs;

  listToSet =
    l: f:
    listToAttrs (
      map (name: {
        name = baseNameOf name;
        value = f name;
      }) l
    );
in

{
  exclude =
    systems: concatMap (system: if elem system rootDirs then floder ./${system} else [ ]) systems;

  packages =
    pkgs:
    listToSet (packageLists ++ attrNames ((import ./override.nix) null pkgs)) (
      name: pkgs.${baseNameOf name}
    );

  overlay =
    final: prev:
    listToSet packageLists (
      name:
      let
        sources = (import ./_sources/generated.nix) {
          inherit (final)
            fetchurl
            fetchgit
            fetchFromGitHub
            dockerTools
            ;
        };
        package = import ./${name};
      in
      final.callPackage package {
        source =
          sources.${baseNameOf name} or {
            pname = "x";
            version = "0.0.0";
            src = ./.;
          };
      }
    );
}
