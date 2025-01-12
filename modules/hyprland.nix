{ inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    # withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.xwaylandvideobridge
    libnotify
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    # --------------------------------------------------- // Display Manager
    #ly                                                    # Install with ly.sh instead
    # --------------------------------------------------- // Window Manager
    hyprcursor
    dunst
    fuzzel
    waybar
    swaybg
    hypridle
    hyprlock
    wlogout
    foot
    #flameshot-git

    # --- Screenshot stack equal to flameshot
    grim
    slurp
    wl-clipboard
    satty-bin
    # ---
    hyprpicker
    pyprland
  ];

  networking.networkmanager.enable = true;
}
