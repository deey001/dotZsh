#!/bin/bash

# uninstall.sh - Remove dotfiles symlinks and clean up Zsh/Oh My Zsh

# Remove symlinks
echo "Removing symlinks..."
rm -f "$HOME/.bash_aliases"
rm -f "$HOME/.bash_exports"
rm -f "$HOME/.bash_profile"
rm -f "$HOME/.bash_wrappers"
rm -f "$HOME/.zshrc"
rm -f "$HOME/.tmux.conf"
rm -f "$HOME/.vimrc"  # Remove .vimrc symlink (backup .bak remains)

# Remove Oh My Zsh and plugins (if installed)
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Removing Oh My Zsh..."
  sh $HOME/.oh-my-zsh/tools/uninstall.sh -y
fi

# Optional: Uninstall Zsh (uncomment with caution)
# sudo apt remove -y zsh

# Clean up tmux plugins (optional: uncomment if desired)
# rm -rf "$HOME/.tmux/plugins"

echo "Uninstall complete! You may need to restart your shell or run 'chsh -s /bin/bash' to revert to Bash."