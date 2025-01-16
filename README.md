# NixOS Install Script

> [!CAUTION]
> Only tested and optimized for VMWare and WSL.

[NixOS](https://nixos.org/) version of my [arch-hyprland](https://github.com/vunhatchuong/arch-hyprland) install script.

Personalize for my [dotfiles](https://github.com/vunhatchuong/.dotfiles).

## Prerequisites

- [NixOS](https://nixos.org/download/#nixos-iso) GUI installation with "no desktop" option or minimal ISO.
- Dotfiles manager: [dotter](https://github.com/SuperCuber/dotter/)

## Installation

### NixOS

Install NixOS from NixoS Minimal ISO with [disko](https://github.com/nix-community/disko).

```bash
sudo su

curl https://dub.sh/6oIiTB3 -o /tmp/disko-config.nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko-config.nix

nixos-generate-config --root /mnt
vim /mnt/etc/nixos/configuration.nix # Optional: add users.users.<username>.initialPassword = "<pass>";

nixos-install
reboot
```

> [!CAUTION]
> This will overrides hardware files inside of `./hosts/hardware` with your own.

```bash
nix-shell -p curl git
sh <(curl -L https://dub.sh/gKZkDnV)
```

To update later:

```bash
nh os switch -H vm
```

To update `flake.lock`:

```bash
nix flake update
sudo nixos-rebuild switch --flake .
```

### WSL

All credits goes to [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config) and [LGUG2Z/nixos-wsl-starter](https://github.com/LGUG2Z/nixos-wsl-starter).

For more information, see [NixOS-WSL](https://github.com/nix-community/NixOS-WSL).

Make a tarball: Run `make wsl`

Then install it:

```bash
wsl --import <name> <storage\path> <.\path\to\tarball.tar.gz> --version 2
...

wsl -d nixos
...

# Optionally, make it the default
wsl -s nixos
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
