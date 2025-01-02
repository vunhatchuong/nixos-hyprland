{ nixpkgs, inputs }:

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
  inherit system;

  modules = [
    ./modules/common.nix

    (if isWSL then inputs.nixos-wsl.nixosModules.wsl else {})

    hostConfig

    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    {
      config._module.args = {
        currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
        isWSL = isWSL;
        inputs = inputs;
      };
    }
  ];
}
