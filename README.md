# nixos flakes

一些命令

```nix
nix eval .#nixosConfigurations.<machine>.config.system.build.toplevel
nix profile diff-closures --profile /nix/var/nix/profiles/system
nix log $(realpath result)

lib.generators.toPretty {} s
```
