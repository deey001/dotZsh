# .zshrc: Zsh configuration file for interactive shells

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme (disabled with Starship)
ZSH_THEME=""

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Oh My Zsh plugins (git, zsh-autosuggestions, zsh-syntax-highlighting)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration
# Export PATH (mirroring previous Bash setup)
export PATH="$PATH:$HOME/bin"

# Alias definitions (mirroring Bash aliases)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ff='cd $(find . -type d | fzf)'

# Fuzzy history search with fzf (Ctrl-R)
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

# Custom numpad bindings for Zsh (adjust sequences with Ctrl-v if needed)
bindkey -s "^[Op" "0"  # Numpad 0
bindkey -s "^[Oq" "1"  # Numpad 1
bindkey -s "^[Or" "2"  # Numpad 2
bindkey -s "^[Os" "3"  # Numpad 3
bindkey -s "^[Ot" "4"  # Numpad 4
bindkey -s "^[Ou" "5"  # Numpad 5
bindkey -s "^[Ov" "6"  # Numpad 6
bindkey -s "^[Ow" "7"  # Numpad 7
bindkey -s "^[Ox" "8"  # Numpad 8
bindkey -s "^[Oy" "9"  # Numpad 9
bindkey -s "^[OM" "\n" # Numpad Enter

# Custom prompt function (mirrored Bash style, overridden by Starship)
function parse_git_branch() {
  local branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ -n "$branch" ]; then
    local dirty=$(git status --porcelain 2> /dev/null | grep -q . && echo "*")
    echo "  ($branch$dirty)"
  fi
}
#PROMPT='%F{green}%n@%m %F{blue}%~%F{yellow}$(parse_git_branch)%f ❯ '  # Commented out, replaced by Starship

# Initialize Starship prompt (overrides default Zsh prompt)
eval "$(starship init zsh)"

# Enable Zsh completion
autoload -Uz compinit && compinit