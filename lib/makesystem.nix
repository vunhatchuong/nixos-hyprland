{ nixpkgs, nixpkgs-unstable, inputs }:

hostname:
{
  system,
  wsl ? false
}:

let
  # True if this is a WSL system.
  isWSL = wsl;

  hostConfig = ../hosts/${hostname}.nix;

  systemFunc = nixpkgs.lib.nixosSystem;
in systemFunc rec {

  # I don't know what I'm doing
  specialArgs = {
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    inherit inputs system;
  };

  inherit system;
  modules = [
    # Bring in WSL if this is a WSL build
    (if isWSL then inputs.nixos-wsl.nixosModules.wsl else {})

    hostConfig

    # Expose some extra arguments so that modules
    # can parameterize better based on these values.
    {
      config._module.args = {
        currentSystem = system;
        currentSystemName = hostname;
        isWSL = isWSL;
        inputs = inputs;
      };
    }
  ];
}
