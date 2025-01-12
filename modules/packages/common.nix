{ pkgs, pkgs-unstable, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      gnumake
      killall
      unzip
      wget
      zip

      dotter                                                 # Main dotfile manager

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
      git-credential-manager
      delta                                                  # Pager for git

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

      micromamba
      hoppscotch
    ])

    ++

    (with pkgs-unstable; [

    ]);

    programs = {
      # Uses with https://github.com/nix-community/nix-direnv
      direnv.enable = true;

      # Patch for mason.nvim
      nix-ld.enable = true;
      zsh = {
        shellInit = ''
          export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
        '';
      };
    };
}
