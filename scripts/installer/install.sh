#!/usr/bin/env bash

# Set strict error handling
set -euo pipefail
IFS=$'\n\t'

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# Logging functions
log_info() {
    printf "${BLUE}INFO: %s${NC}\n" "$1"
}

log_success() {
    printf "${GREEN}SUCCESS: %s${NC}\n" "$1"
}

log_error() {
    printf "${RED}ERROR: %s${NC}\n" "$1" >&2
}

# Create backup directory
setup_backup_dir() {
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
        log_info "Created backup directory at $BACKUP_DIR"
    fi
}

# Backup file if it exists
backup_file() {
    local file="$1"
    if [ -e "$file" ]; then
        local backup_path="$BACKUP_DIR${file#$HOME}"
        mkdir -p "$(dirname "$backup_path")"
        mv "$file" "$backup_path"
        log_info "Backed up $file to $backup_path"
    fi
}

# Create symlink
create_symlink() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ]; then
        if [ -L "$dest" ]; then
            local current_target
            current_target=$(readlink "$dest")
            if [ "$current_target" = "$src" ]; then
                log_info "Link already exists: $dest -> $src"
                return
            fi
        fi
        backup_file "$dest"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    log_success "Created symlink: $dest -> $src"
}

# Detect operating system
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    elif command_exists sw_vers; then
        OS="macOS"
    else
        OS="Unknown"
    fi
    log_info "Detected OS: $OS"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install required packages based on OS
install_packages() {
    case $OS in
    "Arch Linux")
        if command_exists pacman; then
            log_info "Installing packages for Arch Linux..."
            if [ -f "$DOTFILES_DIR/packages/pacman.txt" ]; then
                sudo pacman -Syu --needed - <"$DOTFILES_DIR/packages/pacman.txt"
            fi
        fi
        ;;
    *)
        log_info "Package installation skipped for OS: $OS"
        ;;
    esac
}

# Setup shell configurations
setup_shell() {
    log_info "Setting up shell configurations..."
    create_symlink "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
}

# Setup Hyprland configurations
setup_hyprland() {
    log_info "Setting up Hyprland configurations..."
    create_symlink "$DOTFILES_DIR/config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
    create_symlink "$DOTFILES_DIR/config/hypr/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
    create_symlink "$DOTFILES_DIR/config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
}

# Setup terminal configurations
setup_terminals() {
    log_info "Setting up terminal configurations..."
    create_symlink "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
}

# Setup Neovim configuration
setup_neovim() {
    log_info "Setting up Neovim configuration..."
    create_symlink "$DOTFILES_DIR/config/nvim/" "$HOME/.config/nvim/"
}

# Setup system tools
setup_system_tools() {
    log_info "Setting up system tools..."
    # Dunst
    create_symlink "$DOTFILES_DIR/config/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"

    # Waybar
    create_symlink "$DOTFILES_DIR/config/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
    create_symlink "$DOTFILES_DIR/config/waybar/style.css" "$HOME/.config/waybar/style.css"
}

# Setup Starship prompt
setup_starship() {
    log_info "Setting up Starship prompt..."
    create_symlink "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"
}

# Main function
main() {
    # Get the directory of the current script
    BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")/../../")

    # Source helper file
    source $BASE_DIR/scripts/installer/helper.sh

    # Trap for unexpected exits
    trap 'trap_message' INT TERM

    # Script start
    log_message "Init setup started"
    log_message "This .dotfiles is originally from Simple-Hyprland (https://github.com/gaurav23b/simple-hyprland)"
    echo "---------------"

    setup_backup_dir

    log_info "Starting dotfiles setup..."

    # Detect OS
    detect_os

    # Install required packages
    run_script "init.sh" "Init Setup"
    install_packages

    # Setup all configurations
    setup_shell
    setup_hyprland
    setup_terminals
    setup_neovim
    setup_system_tools
    setup_starship

    log_success "Dotfiles setup completed successfully!"
    log_info "Note: You may need to restart your shell or window manager for all changes to take effect."
}

# Run main function
main "$@"
