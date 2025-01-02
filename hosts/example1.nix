{ config, pkgs, ... }: {

  imports = [
    ./hardware/example1.nix
    ../../modules/common.nix
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;

  # Disable the firewall since we're in a VM and we want to make it
  # easy to visit stuff in here. We only use NAT networking anyways.
  networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?
}
