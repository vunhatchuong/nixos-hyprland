# Hyprland doesn't work well with VM so use X11 and i3
{
  config,
  pkgs,
  lib,
  currentSystem,
  currentSystemName,
  ...
}:
{
  imports = [
    ./hardware/vm.nix
    ../modules/boot.nix
    ../modules/common.nix
    ../modules/disk.nix
    ../modules/fonts.nix
    ../modules/i3.nix
    ../modules/net.nix
    ../modules/nh.nix
    ../modules/nix.nix
    ../modules/packages/common.nix
    ../modules/packages/ui.nix
  ];

  system.stateVersion = "24.11";

  # VMware, Parallels both only support this being 0
  # Fix "error switching console mode" on boot.
  boot.loader.systemd-boot.consoleMode = "0";

  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-bamboo
      ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;

  services.xserver.displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output Virtual-1 --auto
  '';

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true; # Still needs even when enabled in gpg-agent.conf
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  networking.firewall.enable = false; # Disable the firewall since we use NAT.

  # VMWare setup
  virtualisation.vmware.guest.enable = true;
  # services.xserver.videoDrivers = [ "vmware" ]; # Breaks display managers like lightdm
  # Shared folder
  # fileSystems."/host" = {
  #   fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
  #   device = ".host:/<SHARED_FOLDER_NAME>";
  #   options = [
  #     "umask=22"
  #     "uid=1000"
  #     "gid=1000"
  #     "allow_other"
  #     "auto_unmount"
  #     "defaults"
  #   ];
  # };
}
