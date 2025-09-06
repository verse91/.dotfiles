
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':autocomplete:history-incremental-search-backward:*' min-input 1

export ZSH="$HOME/.oh-my-zsh"

plugins=(git
	docker
	docker-compose
	history
	rsync
	safe-paste
	zsh-autosuggestions
	zsh-autocomplete
    zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh


# export MANPATH="/usr/local/man:$MANPATH"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':autocomplete:history-incremental-search-backward:*' min-input 1

export ZSH="$HOME/.oh-my-zsh"
plugins=(git
	docker
	docker-compose
	history
	rsync
	safe-paste
	zsh-autosuggestions
	zsh-autocomplete
    zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

cursorRunApp() {
~/Downloads/Cursor-0.50.5-x86_64.AppImage.zs-old &
}
alias cursor="cursorRunApp"
alias nv="nvim"
alias gr="go run"
alias rm="trash"
alias se="sudoedit"
alias ai="tgpt"
alias cls="clear"

. "$HOME/.local/bin/env"

[ -s "/home/verse/.bun/_bun" ] && source "/home/verse/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"
export QT_QPA_PLATFORMTHEME=qt5ct
export XDG_CONFIG_HOME="$HOME/.config"
export CHROMIUM_FLAGS="--ozone-platform=wayland"
export LANG=en_US.UTF-8
export LC_TIME=vi_VN.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
