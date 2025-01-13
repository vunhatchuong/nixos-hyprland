#!/usr/bin/env nix-shell

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

echo "----------"

REPO_URL="https://github.com/vunhatchuong/nixos-hyprland.git"

DEFAULT_PARENT_DIR="$HOME"

read -p "Enter the parent directory for the clone (default: $DEFAULT_PARENT_DIR): " USER_INPUT
PARENT_DIR="${USER_INPUT:-$DEFAULT_PARENT_DIR}"

NIXOS_CLONE_DIR="$PARENT_DIR/nixos-hyprland"
DOTS_CLONE_DIR="$PARENT_DIR/.dotfiles"

mkdir -p "$PARENT_DIR"

if command -v git &>/dev/null; then
    echo "$OK Git is installed, continuing with installation."
else
    echo "$ERROR Git is not installed. Please install Git and try again."
    echo "Example: nix-shell -p git"
    exit 1
fi

echo "----------"

echo "$INFO Cloning NixOS-Hyprland into: $NIXOS_CLONE_DIR"
git clone https://github.com/vunhatchuong/nixos-hyprland.git $NIXOS_CLONE_DIR

options=("vm" "wsl")
echo "$CAT Choose a hostname: "
select choice in "${options[@]}"; do
    case $choice in
    "vm")
        hostName="vm"
        break
        ;;
    *)
        echo "Invalid option. Please try again."
        ;;
    esac
done

echo "----------"

echo "$INFO Generating Hardware Configuration"
hardware_file="${NIXOS_CLONE_DIR}/hosts/hardware/$hostName.nix"
sudo nixos-generate-config --show-hardware-config >"$hardware_file" 2>/dev/null

echo "$INFO Installing"
NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake "$NIXOS_CLONE_DIR#${hostName}"

cp "${NIXOS_CLONE_DIR}/assets/.condarc" "${PARENT_DIR}"

echo "----------"

echo "$INFO Cloning dotfiles into: $DOTS_CLONE_DIR"
if git clone https://github.com/vunhatchuong/.dotfiles.git $DOTS_CLONE_DIR; then
    cp -r "${NIXOS_CLONE_DIR}/assets/dotfiles-local.toml" "${DOTS_CLONE_DIR}/.dotter/local.toml"
    cd $DOTS_CLONE_DIR
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
