dir:
with builtins;

let
  nixFiles = dir: (map (name: dir + "/${name}")) (filter (v: v != null)
    (attrValues (mapAttrs (k: v: if substring ((stringLength k) - 4) 4 k == ".nix" then k else null) (readDir dir))));
in
{
  imports = (nixFiles ./base) ++ (nixFiles (./${dir}));
}
