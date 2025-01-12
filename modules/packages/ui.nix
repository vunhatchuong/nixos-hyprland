{ pkgs, system, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    polkit_gnome                                           # Authentication agent

    nwg-look                                               # GTK config tool
    libsForQt5.qt5ct                                       # Qt5 config tool
    kdePackages.qt6ct                                      # Qt6 config tool
    libsForQt5.qtstyleplugin-kvantum                       # SVG based Qt6 theme engine

    # Not available yet
    #zen-browser-bin                                        # Browser
    inputs.zen-browser.packages."${system}".specific
    ghostty                                                # Term
    xfce.thunar                                            # File manager
    xfce.thunar-volman                                     # Auto management of removable devices
    xfce.tumbler                                           # Thumbnails
    ffmpegthumbnailer                                      # Thumbnails
    file-roller                                            # Archiver
    xfce.thunar-archive-plugin                             # Archiver
    #ark                                                   # KDE file archiver
    vscode                                                 # VSCode
    mpv                                                    # Video player
    mpvScripts.mpris                                       # MPV mpris support
    bleachbit                                              # Disk cleaner
    obsidian                                               # Note taking
    zathura
    hoppscotch

    jetbrains.idea-community-bin                           # Intellij
  ];
}
