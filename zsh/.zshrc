# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/astat/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/sudo.plugin.zsh
source ~/.zsh/zsh-z/zsh-z.plugin.zsh
# source ~/.zsh/drakula/dracula.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.zplug/init.zsh
# zplug 'dracula/zsh', as:theme
# zplug load --verbose
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure


autoload zkbd
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
# Zsh to use the same colors as ls

LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

alias gpuNV='prime-offload && optimus-manager --switch nvidia'
alias sd='du -hs $(ls -A) | sort -rh'
# alias sd='du -sh [^.]* | sort -rh'
alias sf='du -sh -- *  | sort -rh'
alias ls='ls --color=auto'
alias youtube-dl='yt-dlp'
alias torproxy='sudo tor -f ~/Sync/XAK/tor_tun/torrc_g700 --HTTPTunnelPort 8118'
alias xi='sudo xbps-install -S'
alias xr='sudo xbps-remove -Oo'
alias xq='xbps-query -Rs'
export LC_ALL="en_US.UTF-8"
clear
