{ user, ... }:
{
  # Provide better build output and will also handle GC in place of standard nix GC
  # Usage: nh os switch -H vm
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 10";
    flake = "/home/ronny/nixos-hyprland";
  };
}
