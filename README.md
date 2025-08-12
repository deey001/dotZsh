# Dotfiles

## Files
- .bash_aliases: Custom aliases (compatible with Zsh if sourced).
- .bash_exports: Exported environment variables (compatible with Zsh).
- .bash_profile: Login shell config (compatible with Zsh).
- .bash_wrappers: Custom function wrappers (compatible with Zsh).
- .zshrc: Main Zsh config with Oh My Zsh and plugins.
- .tmux.conf: Tmux config with keybinds, mouse, vi mode, and Dracula plugin.
- .vimrc: Basic Vim configuration.
- install.sh: Installs dependencies, Zsh, Oh My Zsh, plugins, fonts, and symlinks files.
- uninstall.sh: Removes symlinks and Oh My Zsh.

## Installation
1. Clone: git clone https://github.com/deey001/dotfiles.git ~/dotfiles
2. cd ~/dotfiles && ./install.sh
3. Log out and log back in (or run 'zsh') to use Zsh.
4. tmux: prefix + I for plugins

## Uninstallation
./uninstall.sh

Requirements handled by install.sh.