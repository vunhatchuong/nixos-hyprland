#!/usr/bin/env bash

set -euo pipefail

RESET="$(tput sgr0)"
BOLD="$(tput bold)"

BLUE="${BOLD}$(tput setaf 4)"
GREEN="${BOLD}$(tput setaf 2)"
RED="${BOLD}$(tput setaf 1)"
ORANGE="${BOLD}$(tput setaf 166)"
CYAN="${BOLD}$(tput setaf 6)"

INFO="${BOLD}${BLUE}[INFO]${RESET}"
OK="${BOLD}${GREEN}[OK]${RESET}"
ERROR="${BOLD}${RED}[ERROR]${RESET}"
WARN="${BOLD}${ORANGE}[WARN]${RESET}"
CAT="${CYAN}[ACTION]${RESET}"

# -----

REPO_URL="https://github.com/vunhatchuong/nixos-hyprland.git"
CLONE_DIR="$HOME/nixos-hyprland"

if command -v git &>/dev/null; then
    echo "$OK Git is installed, continuing with installation."
    echo "-----"
else
    echo "$ERROR Git is not installed. Please install Git and try again."
    echo "Example: nix-shell -p git"
    exit 1
fi

echo "$INFO Ensure In Home Directory"
cd || exit

# -----

echo "-----"
echo "$INFO Cloning & Entering NixOS-Hyprland Repository"
git clone https://github.com/vunhatchuong/nixos-hyprland.git $HOME/nixos-hyprland
cd $HOME/nixos-hyprland || exit

echo "-----"
options=("vm" "wsl")
echo "$CAT Choose a hostname: "
select choice in "${options[@]}"; do
    case $choice in
    "vm")
        hostName="vm"
        break
        ;;
    "wsl")
        hostName="wsl"
        break
        ;;
    *)
        echo "Invalid option. Please try again."
        ;;
    esac
done

echo "-----"
echo "$INFO Generating Hardware Configuration"
hardware_file="./hosts/hardware/$hostName.nix"
sudo nixos-generate-config --show-hardware-config >"$hardware_file" 2>/dev/null

echo "-----"
echo "Installing"
NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake .#${hostName}

# -----

cp assets/.condarc ~/

echo "-----"

printf "$INFO Cloning dotfiles repository...\n"
if git clone https://github.com/vunhatchuong/.dotfiles.git $HOME/.dotfiles; then
    cp -r "$HOME/nixos-hyprland/assets/dotfiles-local.toml" "$HOME/.dotfiles/.dotter/local.toml"
    cd "$HOME/.dotfiles"
    dotter
    echo -e "${OK} Dotfiles processed successfully."
else
    echo -e "${ERROR} Failed to clone the Dotfiles."
    exit 1
fi

zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --keep

read -rp "${CAT} Would you like to reboot now? (y/n): " HYP
if [[ "$HYP" =~ ^[Yy]$ ]]; then
    systemctl reboot
fi
