#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_prompt_command
fi

source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh
source ~/.dotfiles/h.sh

alias ls='ls --color=auto'
alias grep='grep --color'
alias cgrep='grep --color -r --include=*.{c,cpp,h,hpp}'
alias jgrep='grep --color -r --include=*.java'
alias xmlgrep='grep --color -r --include=*.xml'
alias fcopy="fzf | tr -d '\n' | xclip"

eval "$(dircolors ~/.dircolors)";

export PS1='[\u@\h \[\e[1;34m\]\w\[\e[1;33m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '
export VISUAL="nvim"
export EDITOR="$VISUAL"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Add some colour to LESS/MAN pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;42;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

# History settings
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend
PROMPT_COMMAND='history -a'
