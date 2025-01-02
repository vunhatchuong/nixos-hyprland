# https://github.com/NixOS/nixpkgs/blob/nixos-24.11/pkgs/data/fonts/nerdfonts/shas.nix
{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      hinting.autohint = true;
      subpixel.rgba = "rgb";
    };
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      jetbrains-mono
    ];
  };
}
