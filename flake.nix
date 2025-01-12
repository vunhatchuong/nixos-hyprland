{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Build a custom WSL installer
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: let
    makeSystem = import ./lib/makesystem.nix {
      inherit nixpkgs nixpkgs-unstable inputs;
    };

    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];

  in {

    # Nix formatter: 'nix fmt' https://nix-community.github.io/nixpkgs-fmt
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

    nixosConfigurations.vm = makeSystem "vm" rec {
      system = "x86_64-linux";
    };

    nixosConfigurations.wsl = makeSystem "wsl" {
      system = "x86_64-linux";
      wsl    = true;
    };
  };
}
