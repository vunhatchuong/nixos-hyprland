{ pkgs, pkgs-unstable, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      gnumake
      killall
      unzip
      wget
      zip

      dotter # Main dotfile manager

      starship

      jq
      imagemagick
      sops

      gnupg
      git
      git-credential-manager
      delta

      tmux
      neovim
      fastfetch
      eza
      bat
      fd
      ripgrep
      btop
      fzf
      zoxide

      dust
      duf
      tre-command
      tealdeer
      chafa

      yazi
      lazygit
      lazydocker
      broot
      tmuxp
      hyperfine
      xh
      hurl

      micromamba

      nodejs # Required by neovim
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
