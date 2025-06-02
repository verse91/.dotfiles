# Personal Dotfiles

A carefully curated collection of dotfiles for my Linux development environment.

## Components

### Shell Environment
- Zsh with Oh My Zsh and Powerlevel10k
- Bash configuration
- Starship prompt

### Window Manager
- Hyprland - Wayland compositor
- Hypridle - Idle management
- Hyprlock - Screen locking

### Development Tools
- Neovim with custom configuration
- Terminal emulators:
  - Ghostty
  - Kitty

### System Tools
- Dunst - Notification daemon
- Waybar - Status bar

## Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles

# Run the bootstrap script
cd ~/.dotfiles
./scripts/bootstrap.sh
```

## Structure

```
~/.dotfiles/
├── config/           # Application configurations
├── packages/         # Package lists
├── scripts/         # Utility scripts
├── shell/           # Shell configurations
└── themes/          # Theme configurations
```

## Features

- Automated setup via bootstrap script
- Backup of existing configurations
- Package management for Arch Linux
- Symlink-based configuration management
- Separation of sensitive information

## Customization

1. Fork this repository
2. Modify configurations as needed
3. Update packages/pacman.txt for new dependencies
4. Update bootstrap.sh for new configurations

## License

MIT License - See LICENSE file for details
