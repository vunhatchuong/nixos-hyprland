{
  pkgs,
  system,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # --------------------- // Core
    polkit_gnome # Authentication agent

    nwg-look # GTK config tool
    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum # SVG based Qt6 theme engine
    # ---------------------

    # --------------------------------------------------- // Applications
    MapleMono-NF
    #zen-browser-bin                                        # Not available yet
    inputs.zen-browser.packages."${system}".specific
    ghostty
    # ------------------------- // Linux specific
    xfce.thunar
    xfce.thunar-volman
    xfce.tumbler
    ffmpegthumbnailer
    file-roller
    xfce.thunar-archive-plugin
    #ark                                                   # KDE file archiver
    mpv
    mpvScripts.mpris
    # -------------------------

    flameshot
    discord
    bleachbit
    transmission
    obsidian
    speedcrunch # GUI calculator
    # PDF Viewer
    zathura
    sioyek

    # --------------------------------------------------- // Devs
    vscode
    jetbrains.idea-community-bin
    hoppscotch # Wait for yaak
  ];
}
