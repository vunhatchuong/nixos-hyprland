{ config, lib, inputs, ... }:
{
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # See https://jackson.dev/post/nix-reasonable-defaults/
    settings = {
      connect-timeout = 5;
      min-free = 128000000;  # 128MB
      max-free = 1000000000; # 1GB

      fallback = true;

      auto-optimise-store = true;
      warn-dirty = false;

      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
