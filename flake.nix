{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Build a custom WSL installer
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:MarceColl/zen-browser-flake";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      systems,
      treefmt-nix,
      ...
    }@inputs:
    let
      makeSystem = import ./lib/makesystem.nix {
        inherit nixpkgs nixpkgs-unstable inputs;
      };

      forAllSystems = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = forAllSystems (pkgs: treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
      });

    in
    {

      formatter = forAllSystems (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      checks = forAllSystems (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });

      nixosConfigurations.vm = makeSystem "vm" rec {
        system = "x86_64-linux";
      };

      nixosConfigurations.wsl = makeSystem "wsl" {
        system = "x86_64-linux";
        wsl = true;
      };
    };
}
