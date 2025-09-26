# Prompt + zoxide
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Autocomplete history search
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':autocomplete:history-incremental-search-backward:*' min-input 1

# Oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
  docker
  docker-compose
  history
  rsync
  safe-paste
  zsh-autosuggestions
  zsh-autocomplete
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

tma() {
  local index=$1
  local session=$(tmux list-sessions -F "#{session_name}" | sed -n "${index}p")
  tmux attach -t "$session"
}

# Aliases
alias nv="nvim"
alias gr="go run"
alias rm="trash"
alias se="sudoedit"
alias ai="tgpt"
alias cls="clear"
alias lc="locate"
alias lg="lazygit"
alias tm="tmux"
alias tk="tmux kill-server"
alias ta="tmux a -t"
alias ca="cursor-agent"
# Local env
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
# uv
export PATH="$HOME/.local/bin:$PATH"

# Bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Env vars
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"
export QT_QPA_PLATFORMTHEME=qt5ct
export XDG_CONFIG_HOME="$HOME/.config"
export CHROMIUM_FLAGS="--ozone-platform=wayland"
export LANG=en_US.UTF-8
export LC_TIME=vi_VN.UTF-8
export EDITOR=nvim
eval "$(uv generate-shell-completion zsh)"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$HOME/.cargo/bin:$PATH"
