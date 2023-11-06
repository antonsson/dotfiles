#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

#------------------------------
# Variables
#------------------------------
export BROWSER="firefox"
export EDITOR="nvim"
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.cargo/bin"

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Keybindings
#------------------------------
bindkey -v
typeset -g -A key
bindkey "^R" history-incremental-pattern-search-backward

#------------------------------
# Alias stuff
#------------------------------
alias ls="ls --color"
alias grep='grep --color'
alias screencap='grim -g "$(slurp)"'
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias env-private='export GIT_SSH_COMMAND="ssh -o IdentitiesOnly=yes -i $HOME/.ssh/id_rsa -F /dev/null"'
alias env-cf='export GIT_SSH_COMMAND="ssh -o IdentitiesOnly=yes -i $HOME/.ssh/id_crunchfish -F /dev/null"'
alias imgcat='wezterm imgcat'

#------------------------------
# Comp stuff
#------------------------------
zmodload zsh/complist
autoload -Uz compinit
setopt noautomenu
setopt nomenucomplete
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

#------------------------------
# Window title
#------------------------------
case $TERM in
  termite|*xterm*|foot|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      vcs_info
      print -Pn "\e]0;%n@%M:%~\a"
    }
    ;;
  screen|screen-256color)
    precmd () {
      vcs_info
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
    }
    preexec () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
    }
    ;;
esac

#------------------------------
# Prompt
#------------------------------
autoload -U colors zsh/terminfo
colors

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats " %{${fg[yellow]}%}(%b)%{$reset_color%}"

bindkey -v
function zle-line-init zle-keymap-select {
    suffix=$''
    case ${KEYMAP} in
        (vicmd)      suffix=$'%F{red}$%f ' ;;
        (main|viins) suffix=$'$ ' ;;
        (*)          suffix=$'$ ' ;;
    esac
    PS1="[%n@%M %F{blue}%~%f${vcs_info_msg_0_}]${suffix}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

setprompt() {
  setopt prompt_subst

  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    p_host='%F{yellow}%M%f'
  else
    p_host='%F{green}%M%f'
  fi

  PS1="[%n@%M %F{blue}%~%f]$ "
}
setprompt
