{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Build a custom WSL installer
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, ... }@inputs: let
    makeSystem = import ./lib/makesystem.nix {
      inherit overlays nixpkgs inputs;
    };

  in {
    nixosConfigurations.vm-intel = makeSystem "vm-intel" rec {
      system = "x86_64-linux";
    };

    nixosConfigurations.wsl = makeSystem "wsl" {
      system = "x86_64-linux";
      wsl    = true;
    };
  };
}
