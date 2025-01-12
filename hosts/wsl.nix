{ pkgs, currentSystemUser, ... }:
{
  imports = [
    ../modules/common.nix
    ../modules/net.nix
    ../modules/nh.nix
    ../modules/nix.nix
    ../modules/packages/common.nix
  ];

  system.stateVersion = "24.11";

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "ronny";
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;
  };
}
