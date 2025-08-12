# dotZsh

## Files
- .bash_aliases: Custom aliases for common commands.
- .bash_exports: Exported environment variables.
- .bash_profile: Login shell config.
- .bash_wrappers: Custom function wrappers.
- .zshrc: Zsh config with Oh My Zsh and modern prompt.
- .tmux.conf: Tmux config with keybinds, mouse, vi mode, and Dracula plugin.
- .vimrc: Basic Vim configuration.
- install.sh: Installs dependencies, fonts, vim, Zsh with Oh My Zsh, Starship, and symlinks files.
- uninstall.sh: Removes symlinks.
- .config/starship.toml: Starship prompt configuration.

## Installation
1. Clone: git clone https://github.com/deey001/dotZsh.git ~/dotZsh
2. cd ~/dotZsh && ./install.sh
3. tmux: prefix + I for plugins
4. (Optional) Set Zsh as default shell: uncomment 'chsh -s $(which zsh)' in install.sh and rerun.

## Uninstallation
./uninstall.sh

Requirements handled by install.sh.