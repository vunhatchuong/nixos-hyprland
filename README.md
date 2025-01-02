# NixOS Install Script

[NixOS](https://nixos.org/) version of my [arch-hyprland](https://github.com/vunhatchuong/arch-hyprland) install script.

Personalize for my [dotfiles](https://github.com/vunhatchuong/.dotfiles).

## Prerequisites

- [NixOS](https://nixos.org/download/#nixos-iso) GUI installation with "no desktop" option.
- Dotfiles manager: [dotter](https://github.com/SuperCuber/dotter/)

## Usage

Installation

```bash
nix-shell -p git curl
sh <(curl -L https://github.com/vunhatchuong/nixos-hyprland/raw/main/install.sh)
```

To update later:

```bash
nh os switch -H vm
```

## Theme

- Theme for others: [Sequoia-Theme](https://github.com/Sequoia-Theme/)

## Credits

- [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config): Main motivator.
- [Andrey0189/nixos-config-reborn](https://github.com/Andrey0189/nixos-config-reborn)
- [paradoxical-dev/dots](https://github.com/paradoxical-dev/dots)

## Resources

- [NixOS options search](https://search.nixos.org/options)
- [NixOS packages search](https://search.nixos.org/packages)
- [NixOS release notes](https://nixos.org/manual/nixos/stable/release-notes)
- [mynixos](https://mynixos.com/)
