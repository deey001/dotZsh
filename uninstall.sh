#!/bin/bash

# uninstall.sh - Remove dotfiles symlinks and clean up Starship/vim/Zsh

# Remove symlinks
echo "Removing symlinks..."
rm -f "$HOME/.zsh_aliases"
rm -f "$HOME/.zsh_exports"
rm -f "$HOME/.zprofile"
rm -f "$HOME/.zshrc"
rm -f "$HOME/.tmux.conf"
rm -f "$HOME/.config/starship.toml"
rm -f "$HOME/.vimrc"  # Remove .vimrc symlink (backup .bak remains)

# Remove Starship init from .zshrc (if present)
sed -i '/# Initialize Starship prompt/d' "$HOME/.zshrc"
sed -i '/eval "$(starship init zsh)"/d' "$HOME/.zshrc"

# Optional: Uninstall Starship binary (uncomment if desired)
# command -v starship &> /dev/null && curl -sS https://starship.rs/install.sh | sh -s -- --uninstall

# Optional: Uninstall vim (uncomment with caution)
# if [ "$(uname)" = "Darwin" ]; then
#   brew uninstall vim
# elif [ "$(uname)" = "Linux" ]; then
#   sudo apt remove -y vim
# fi

# Optional: Uninstall Oh My Zsh and Zsh (uncomment with caution)
# if [ -d "$HOME/.oh-my-zsh" ]; then
#   rm -rf "$HOME/.oh-my-zsh"
# fi
# sudo apt remove -y zsh

# Clean up tmux plugins (optional: uncomment if desired)
# rm -rf "$HOME/.tmux/plugins"

echo "Uninstall complete! You may need to restart your shell or reset default shell with 'chsh -s /bin/bash' if changed."