{ inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    # withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.xwaylandvideobridge
    libnotify
    xdg-desktop-portal-hyprland                            # Portal for hyprland
    xdg-desktop-portal-gtk                                 # Portal for gtk

    # --------------------------------------------------- // Display Manager
    #ly                                                    # Install with ly.sh instead
    # --------------------------------------------------- // Window Manager
    hyprcursor                                             # Cursor
    dunst                                                  # Notification daemon
    fuzzel                                                 # App launcher
    waybar                                                 # System bar
    swaybg                                                 # Wallpaper
    hypridle                                               # Idle daemon
    hyprlock                                               # Lock screen
    wlogout                                                # Logout menu
    foot                                                   # Term
    #flameshot-git

    # --- Screenshot stack equal to flameshot
    grim                                                   # Grab images from a Wayland compositor
    slurp
    wl-clipboard
    satty-bin
    # ---
    hyprpicker                                             # Color picker
    pyprland                                               # Extends Hyprland functionality
  ];

  networking.networkmanager.enable = true;
}
