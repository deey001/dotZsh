# .zshrc: Zsh configuration file for interactive shells

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme (use a simple theme like robbyrussell, or customize later)
ZSH_THEME="robbyrussell"

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Oh My Zsh plugins (add git, zsh-autosuggestions, zsh-syntax-highlighting)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration
# Export PATH (mirroring Bash setup)
export PATH="$PATH:$HOME/bin"

# Alias definitions (mirroring Bash aliases)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Fuzzy finder alias (same as Bash)
alias ff='cd $(find . -type d | fzf)'

# Custom prompt function (mirroring Bash style with Nerd Font)
function parse_git_branch() {
  local branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ -n "$branch" ]; then
    local dirty=$(git status --porcelain 2> /dev/null | grep -q . && echo "*")
    echo "  ($branch$dirty)"
  fi
}
PROMPT='%F{green}%n@%m %F{blue}%~%F{yellow}$(parse_git_branch)%f ❯ '

# Enable Zsh completion
autoload -Uz compinit && compinit

# Source additional configuration files
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.zsh_exports ] && source ~/.zsh_exports