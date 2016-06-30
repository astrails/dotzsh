alias .='pwd'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ls='ls -FG'
alias ll='ls -FGl'

if which pbcopy > /dev/null; then
  alias p=pbcopy
fi
