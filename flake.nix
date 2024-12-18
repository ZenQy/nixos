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
        with builtins;
        let
          modules_ = {
            desktop = [
              (import ./modules "desktop")
              impermanence.nixosModule
            ];
            server = [ (import ./modules "server") ];
            nas = [ (import ./modules "nas") ];
          };

          hostList = {
            desktop = [ "beelink" ];
            server = [
              "claw"
              "tokyo-1"
              "tokyo-2"
              "osaka-1"
              "osaka-2"
              "osaka-arm"
              "natvps"
              "alice"
            ];
            nas = [
              "rock-5b"
              "tx3"
            ];
          };

          hosts = listToAttrs (
            concatMap (
              type:
              map (host: {
                name = host;
                value = modules_.${type};
              }) hostList.${type}
            ) (attrNames hostList)
          );
        in
        mapAttrs (
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
            ] ++ module;
          }
        ) hosts;
    };
}
