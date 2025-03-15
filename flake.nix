{
  description = "ZenQy's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    secrets = {
      # url = "/home/nixos/Documents/nixos-secrets";
      url = "git+ssh://git@github.com/zenqy/nixos-secrets";
      flake = false;
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    {
      self,
      nixpkgs,
      secrets,
      impermanence,
    }:

    with builtins;
    let
      this = import ./pkgs;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

    in
    {
      overlays.default =
        final: prev: (nixpkgs.lib.composeExtensions this.overlay (import ./pkgs/override.nix) final prev);

      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
            config.allowUnfree = true;
            config.allowUnsupportedSystem = true;
          };
        in
        removeAttrs (this.packages pkgs) (this.exclude (filter (s: s != system) systems))
      );

      apps = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          home = import ./modules/desktop/home {
            inherit pkgs;
            lib = nixpkgs.lib;
          };
        in
        {
          default = {
            type = "app";
            program = "${home.gen}";
          };
        }
      );

      nixosConfigurations =
        let
          category = filter (x: x != "deprecated") (attrNames (readDir ./hosts));
          hosts = cate: attrNames (readDir ./hosts/${cate});

          value =
            cate: host:
            let
              system =
                if
                  elem host [
                    "osaka-arm"
                    "tx3"
                    "rock-5b"
                    "e20c"
                  ]
                then
                  "aarch64-linux"
                else
                  "x86_64-linux";
            in
            nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                secrets = import (secrets + "/secrets.nix");
              };
              modules = [
                ./hosts/${cate}/${host}
                (import ./modules cate)
                (if cate == "desktop" then (impermanence.nixosModule) else { })
                {
                  nixpkgs.overlays = [ self.overlays.default ];
                  nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
                  networking.hostName = host;
                }
              ];
            };
        in
        listToAttrs (
          concatMap (
            cate:
            map (host: {
              name = host;
              value = value cate host;
            }) (hosts cate)
          ) category
        );
    };
}
