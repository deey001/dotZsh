#!/bin/bash

# install.sh - Install dotfiles, dependencies, vim, Zsh with Oh My Zsh, Starship, and Nerd Font

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OS="$(uname)"
if [ "$OS" = "Darwin" ]; then
  # macOS
  if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  echo "Installing tmux, git, fzf, vim, zsh, starship via Homebrew..."
  brew install tmux git fzf vim zsh starship
  brew install --cask font-jetbrains-mono-nerd-font
elif [ "$OS" = "Linux" ]; then
  # Assume Debian-based; adjust for other distros
  sudo apt update
  echo "Installing tmux, git, fzf, vim, zsh, xclip, bash-completion, zoxide..."
  sudo apt install -y tmux git fzf vim zsh xclip bash-completion zoxide
  if [ -n "$WAYLAND_DISPLAY" ]; then
    sudo apt install -y wl-clipboard
  fi
  # Install Starship
  curl -sS https://starship.rs/install.sh | sh -s -- -y
  # Install JetBrainsMono Nerd Font
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts
  curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
  tar xvf JetBrainsMono.tar.xz
  rm JetBrainsMono.tar.xz
  fc-cache -fv
  fc-list | grep JetBrainsMono
  # Install Oh My Zsh
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
else
  echo "Unsupported OS: $OS"
  exit 1
fi

# Install Zsh plugins
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Symlink dotfiles including .config/starship.toml and .vimrc (backup existing .vimrc)
echo "Creating symlinks..."
ln -sf "$DOTFILES_DIR/.zsh_aliases" "$HOME/.zsh_aliases"
ln -sf "$DOTFILES_DIR/.zsh_exports" "$HOME/.zsh_exports"
ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
if [ -f "$HOME/.vimrc" ]; then
  mv "$HOME/.vimrc" "$HOME/.vimrc.bak"  # Backup existing .vimrc
fi
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# Append Starship init to .zshrc if not present (redundant but as fallback)
if ! grep -q "starship init zsh" "$HOME/.zshrc"; then
  echo '# Initialize Starship prompt' >> "$HOME/.zshrc"
  echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

# Set Zsh as default shell (optional, uncomment if desired)
# chsh -s $(which zsh)

# Source Zsh profile
source "$HOME/.zshrc"

echo "Start tmux and press prefix + I to install plugins."
echo "Setup complete! Restart your terminal or use 'zsh' to start a Zsh session."