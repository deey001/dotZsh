#!/bin/bash

# install.sh - Install dotfiles, Zsh, Oh My Zsh, plugins, dependencies, and Nerd Font

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OS="$(uname)"
if [ "$OS" = "Darwin" ]; then
  # macOS
  if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  echo "Installing zsh, tmux, git, fzf, vim via Homebrew..."
  brew install zsh tmux git fzf vim
  # Font on macOS
  brew install --cask font-jetbrains-mono-nerd-font
elif [ "$OS" = "Linux" ]; then
  # Assume Debian-based; adjust for other distros
  sudo apt update
  echo "Installing zsh, tmux, git, fzf, vim, xclip..."
  sudo apt install -y zsh tmux git fzf vim xclip
  if [ -n "$WAYLAND_DISPLAY" ]; then
    sudo apt install -y wl-clipboard
  fi
  # Install JetBrainsMono Nerd Font
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts
  curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
  tar xvf JetBrainsMono.tar.xz
  rm JetBrainsMono.tar.xz
  fc-cache -fv
  fc-list | grep JetBrainsMono
else
  echo "Unsupported OS: $OS"
  exit 1
fi

# Clone TPM if not present
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Cloning Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install Oh My Zsh (non-interactive to avoid errors in Bash script)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Symlink dotfiles including .zshrc and .vimrc (backup existing .zshrc/.vimrc)
echo "Creating symlinks..."
ln -sf "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases"  # Keep if you have Bash aliases to source in Zsh
ln -sf "$DOTFILES_DIR/.bash_exports" "$HOME/.bash_exports"  # Keep if you have exports
ln -sf "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"  # Keep if needed
ln -sf "$DOTFILES_DIR/.bash_wrappers" "$HOME/.bash_wrappers"  # Keep if needed
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
if [ -f "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"  # Backup existing .zshrc
fi
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
if [ -f "$HOME/.vimrc" ]; then
  mv "$HOME/.vimrc" "$HOME/.vimrc.bak"  # Backup existing .vimrc
fi
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# Set Zsh as default shell
chsh -s $(which zsh)

echo "Setup complete! Log out and log back in to use Zsh, or run 'zsh'."
echo "Start tmux and press prefix + I to install plugins."