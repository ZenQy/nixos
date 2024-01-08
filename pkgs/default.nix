with builtins;
let
  categories = filter (v: v != null) (attrValues (mapAttrs (k: v: if k != "deprecated" && v == "directory" then k else null) (readDir ./.)));
  packageLists = filter (v: v != null) (concatLists (map (dir: attrValues (mapAttrs (k: v: if v == "directory" then "${dir}/${k}" else null) (readDir ./${dir}))) categories));
  listToSet = l: f: listToAttrs (map (name: { name = baseNameOf name; value = f name; }) l);
in

{
  packages = pkgs: listToSet
    (packageLists ++ attrNames ((import ./override.nix) null pkgs))
    (name: pkgs.${baseNameOf name});

  overlay = final: prev: listToSet packageLists
    (name:
      let
        sources = (import ./_sources/generated.nix) {
          inherit (final) fetchurl fetchgit fetchFromGitHub dockerTools;
        };
        package = import ./${name};
        # args = intersectAttrs (functionArgs package) { source = sources.${baseNameOf name}; };
      in
      final.callPackage package {
        source = sources.${baseNameOf name} or {
          pname = "x";
          version = "0.0.0";
          src = ./.;
        };
      }  # args
    );
}
