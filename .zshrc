# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Theme (choose one: robbyrussell, agnoster, powerlevel10k if installed, etc.)
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Enable completions
autoload -Uz compinit && compinit

# Load syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source /home/kaarthiks/.oh-my-zsh/custom/plugins/nix-shell/nix-shell.plugin.zsh

# Aliases
alias v='nvim'
alias c='clear'
alias t='tmux'
alias x='exit'
alias doc='docker'
alias sz='source ~/.zshrc'
alias sb='source ~/.bashrc'
alias st='source ~/.tmux.conf'
alias ez='nvim ~/.zshrc'
alias eb='nvim ~/.bashrc'
alias et='nvim ~/.tmux.conf'
alias es='nvim ~/.config/starship.toml'
alias pbcopy="xclip -sel clip"
alias please='sudo'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gac='git add . && git commit -m '
alias stfu='sudo shutdown -h now'
alias rb='sudo reboot'
alias py='python3'

if [ -n "$IN_NIX_SHELL" ]; then
  echo "NIX....."
  source $ZSH_CUSTOM/plugins/nix-shell/nix-shell.plugin.zsh
fi

# Start clean
clear
