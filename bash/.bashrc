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

alias ls='ls --color=auto'
alias grep='grep --color'
alias cgrep='grep --color -r --include=*.{c,cpp,h,hpp}'
alias jgrep='grep --color -r --include=*.java'
alias xmlgrep='grep --color -r --include=*.xml'
alias fcopy="fzf | tr -d '\n' | xclip"
alias xnclip="tr -d '\n' | xclip"
alias ssh="kitty +kitten ssh"
alias icat="kitty +kitten icat"
alias screencap='grim -g "$(slurp)"'
alias gitroot='cd $(git rev-parse --show-toplevel)'

export PS1='[\u@\h \[\e[1;34m\]\w\[\e[1;33m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '
export VISUAL="nvim"
export EDITOR="$VISUAL"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Add some colour to LESS/MAN pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33m'
export LESS_TERMCAP_ue=$'\e[1;31m'
export LESS_TERMCAP_us=$'\e[1;31m'

# History settings
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend
PROMPT_COMMAND='history -a'


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
