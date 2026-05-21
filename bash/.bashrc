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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

x509-info() {
  local input="$*"

  # Strip brackets [], quotes (' and "), and whitespace
  input="${input//[\[\]]/}"        # remove [ and ]
  input="${input//\"/}"            # remove "
  input="${input//\'/}"            # remove '
  input="$(printf '%s' "$input" | tr -d '[:space:]')"  # remove spaces/newlines

  IFS=',' read -ra certs <<< "$input"
  local i=1
  for cert in "${certs[@]}"; do
    [ -z "$cert" ] && continue
    echo "----- CERTIFICATE $i -----"
    printf '%s' "$cert" | base64 -d 2>/dev/null \
      | openssl x509 -inform DER -text || echo "Error: failed to decode certificate #$i" >&2
    echo
    i=$((i+1))
  done
}
