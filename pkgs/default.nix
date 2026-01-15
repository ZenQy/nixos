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
  packages =
    system: pkgs: pkgs_:
    listToSet (packageLists ++ attrNames ((import ./override.nix) null pkgs)) (
      name:
      let
        shortName = baseNameOf name;
        sources = (import ./_sources/generated.nix) {
          inherit (pkgs_)
            fetchurl
            fetchgit
            fetchFromGitHub
            dockerTools
            ;
        };
      in
      if system == "x86_64-linux" && elem shortName (floder ./aarch64-linux) then
        pkgs_.callPackage ./${name} {
          source =
            sources.${baseNameOf name} or {
              pname = "x";
              version = "0.0.0";
              src = ./.;
            };
        }
      else
        pkgs.${shortName}
    );

  overlay =
    final: prev:
    (listToSet packageLists (
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
