{ config, pkgs, lib, systemSettings, userSettings, grub2-themes, sddm-sugar-candy-nix, ... }:
{
  system.stateVersion = "24.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = systemSettings.hostname; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #ZSH
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    cron
    upower
    brightnessctl
    libnotify
    wget
    curl
    unzip
    ripgrep

    git
    tmux
    neovim
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
