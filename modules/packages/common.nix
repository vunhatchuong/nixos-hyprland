{ pkgs, pkgs-unstable, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      killall

      unzip
      wget
      zip

      nodejs
      python311
      micromamba

      hoppscotch

      dotter                                                 # Main dotfile manager
      zsh                                                    # ZSH shell
      starship                                               # Shell prompt

      jq                                                     # JSON processing
      imagemagick                                            # Image processing

      tmux                                                   # Term multiplexer
      neovim                                                 # Term text editor
      fastfetch                                              # System info fetch tool
      eza                                                    # Better ls
      bat                                                    # Better cat
      fd                                                     # Better find
      ripgrep                                                # Better grep
      btop                                                   # Resource monitor
      fzf                                                    # fuzzy finder
      zoxide                                                 # Better cd

      gnupg
      git
      git-credential-manager                                 # Run git-credential-manager configure after
      delta                                                  # Syntax highlight for git

      lazygit                                                # Git UI
      lazydocker                                             # Docker UI
      tre-command                                            # Better tree
      broot                                                  # Navigation
      hyperfine                                              # Benchmark
      yazi                                                   # TUI file manager
      chafa                                                  # Image previewer
      dust                                                   # Disk usage analyzer
      duf                                                    # Disk Usage
      tldr                                                   # TLDR for man pages
    ])

    ++

    (with pkgs-unstable; [

    ]);
}
