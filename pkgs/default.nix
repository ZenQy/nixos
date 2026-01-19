let
  inherit (builtins)
    attrNames
    attrValues
    concatMap
    elem
    filter
    listToAttrs
    mapAttrs
    readDir
    ;

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

  packageList = concatMap (dir: map (subdir: "${dir}/${subdir}") (floder ./${dir})) rootDirs;

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
  packages =
    system: pkgs:
    let
      newPackageList = filter (
        name: !(system == "x86_64-linux" && elem (baseNameOf name) (floder ./aarch64-linux))
      ) packageList;
    in
    listToSet (newPackageList ++ attrNames ((import ./override.nix) null pkgs)) (
      name: pkgs.${baseNameOf name}
    );

  overlay =
    final: prev:
    (listToSet packageList (
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
      in
      final.callPackage ./${name} {
        source =
          sources.${baseNameOf name} or {
            pname = "x";
            version = "0.0.0";
            src = ./.;
          };
      }
    ))
    // (import ./override.nix final prev);
}
