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

    let
      this = import ./pkgs;
      desktop = import ./modules "desktop";
      server = import ./modules "server";
      nas = import ./modules "nas";
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

    in
    {
      overlays.default =
        final: prev: (nixpkgs.lib.composeExtensions this.overlay (import ./pkgs/override.nix) final prev);

      nixosModules.desktop =
        { ... }:
        {
          imports = [
            desktop
            impermanence.nixosModule
          ];
        };
      nixosModules.server =
        { ... }:
        {
          imports = [ server ];
        };

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
        this.packages pkgs
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
          d = self.nixosModules.desktop;
          s = self.nixosModules.server;
          hosts = {
            beelink = d;
            cc = s;
            tokyo-1 = s;
            tokyo-2 = s;
            osaka-1 = s;
            osaka-2 = s;
            osaka-arm = s;
            crbs = s;
            rock-5b = nas;
            tx3 = nas;
          };
        in
        builtins.mapAttrs (
          host: module:
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              secrets = import (secrets + "/secrets.nix");
            };
            modules = [
              ./hosts/${host}
              {
                nixpkgs.overlays = [ self.overlays.default ];
                nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
                networking.hostName = host;
              }
              module
            ];
          }
        ) hosts;
    };
}
