# Notes

General notes about everything I learned.

## Commands

- Search with `nix search wget`.
- Installation: `nix-shell -p git --command "nix run --experimental-features 'nix-command flakes' github:vunhatchuong/nixos-hyprland"`.
- Setup: `sudo nixos-rebuild switch --flake .#hostname`.

## Development


Inspired by [mitchellh](https://github.com/mitchellh/nixos-config/) setup.

### Resources

- [Effortless dev environments with Nix and direnv](https://determinate.systems/posts/nix-direnv/)
- [the-nix-way/dev-templates: Dev env templates for langs based on flakes](https://github.com/the-nix-way/dev-templates)
- [nix-community/nix-direnv](https://github.com/nix-community/nix-direnv)
- [datsfilipe/nvim-colorscheme-template](https://github.com/datsfilipe/nvim-colorscheme-template)

## Resources

- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [librephoenix/nixos-config](https://gitlab.com/librephoenix/nixos-config)
- [EmergentMind/nix-config](https://github.com/EmergentMind/nix-config)
- [EdenEast/nyx](https://github.com/EdenEast/nyx)
- [Zaney/zaneyos](https://gitlab.com/Zaney/zaneyos)
