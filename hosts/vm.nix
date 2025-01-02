# Hyprland doesn't work well with VM so use X11 and i3
{ config, pkgs, lib, currentSystem, currentSystemName,... }: {
  imports = [
    ./hardware/vm.nix
    ../modules/boot.nix
    ../modules/common.nix
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

  environment.systemPackages = with pkgs; [
    # For hypervisors that support auto-resizing, this script forces it.
    # I've noticed not everyone listens to the udev events so this is a hack.
    (writeShellScriptBin "xrandr-auto" ''
      xrandr --output Virtual-1 --auto
    '')
  ] ++ lib.optionals (currentSystemName == "vm-aarch64") [
    # This is needed for the vmware user tools clipboard to work.
    # You can test if you don't need this by deleting this and seeing
    # if the clipboard sill works.
    gtkmm3
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  # services.gpg-agent = {
  #   enable = true;
  #   pinentryPackage = pkgs.pinentry-tty;
  # };

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
  #   device = ".host:/";
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
