#
# ~/.bashrc
#

source /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-prompt.sh

alias ls='ls --color=auto'
alias grep='grep --color'
alias cgrep='grep --color -r --include=*.{c,cpp,h,hpp}'
alias jgrep='grep --color -r --include=*.java'
alias xmlgrep='grep --color -r --include=*.xml'
alias fcopy="fzf | tr -d '\n' | xclip"
alias xnclip="tr -d '\n' | xclip"
alias screencap='grim -g "$(slurp)"'
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias env-private='export GIT_SSH_COMMAND="ssh -o IdentitiesOnly=yes -i $HOME/.ssh/id_rsa -F /dev/null"'
alias env-cf='export GIT_SSH_COMMAND="ssh -o IdentitiesOnly=yes -i $HOME/.ssh/id_crunchfish -F /dev/null"'
alias imgcat='wezterm imgcat'

shopt -s histappend

export HISTCONTROL=ignoredups:erasedups:ignorespace

export PS1='[\u@\h \[\e[1;34m\]\w\[\e[1;33m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '

export FZF_DEFAULT_OPTS="--exact"
eval "$(fzf --bash)"
