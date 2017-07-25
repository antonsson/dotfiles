#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/bin/git-completion.bash
source ~/bin/git-prompt.sh

alias ls='ls --color=auto'
alias grep='grep --color'
alias cgrep='grep --color -r --include=*.{c,cpp,h,hpp}'
alias jgrep='grep --color -r --include=*.java'
alias xmlgrep='grep --color -r --include=*.xml'
alias jira-ads="jira jql 'project = ADS AND resolution = Unresolved AND assignee in (EMPTY)'"

export PS1='[\u@\h \[\e[1;34m\]\w\[\e[1;33m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
