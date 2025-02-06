{
  pkgs,
  system,
  inputs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    polkit_gnome # Authentication agent

    nwg-look # GTK config tool
    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum # SVG based Qt6 theme engine

    # Not available yet
    #zen-browser-bin                                        # Browser
    inputs.zen-browser.packages."${system}".specific
    ghostty
    xfce.thunar
    xfce.thunar-volman
    xfce.tumbler
    ffmpegthumbnailer
    file-roller
    xfce.thunar-archive-plugin
    #ark                                                   # KDE file archiver
    vscode
    mpv
    mpvScripts.mpris
    bleachbit
    obsidian
    zathura
    hoppscotch
    speedcrunch

    jetbrains.idea-community-bin

    zathura
    sioyek
  ];
}
