fpath=(~/.zsh/functions $fpath)

# ALIASES
alias .='pwd'
alias ...='cd ../..'
alias ....='cd ../../..'

alias g='git'

alias ls='ls -FG'
alias ll='ls -FGl'

alias sc=./script/console
alias ss=./script/server
alias s3=/aws/s3cmd/s3cmd

function ec2() {
  local ec2_conf=~/.aws/$1/ec2.sh
  local s3_conf=~/.aws/$1/s3.config

  if [ -e $ec2_conf ]; then
  echo "found ec2 conf $ec2_conf"
    source $ec2_conf
  else
    echo "NOT found ec2 conf"
  fi

  if [ -e $s3_conf ]; then
    echo "found s3 conf $s3_conf"
    ln -sfn $s3_conf ~/.s3cfg
  else
    echo "NOT found s3 cong"
  fi
}

function mm() { pwd > ~/.mm }
function gg() { cd `cat ~/.mm` }

# COLORS
autoload colors; colors;

unset LSCOLORS
export LSCOLORS="Gxfxcxdxbxegedabagacad"


# GREP
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# HISTORY
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_dups
setopt appendhistory


# OPTIONS
export PAGER=less
export EDITOR=vim
export LC_CTYPE=en_US.UTF-8
setopt autocd
setopt auto_pushd
setopt extendedglob
setopt auto_name_dirs
setopt multios
setopt cdablevars
unsetopt beep nomatch

autoload -U select-word-style; select-word-style bash


# COMPLETION
autoload -Uz compinit; compinit

# zstyle ':completion:*' completer ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' max-errors 1
# zstyle ':completion:*' menu select=1
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle :compinstall filename '/home/astrails/.zshrc'


setopt auto_menu
unsetopt menu_complete

zmodload -i zsh/complist

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
zstyle ':completion:*:*:*:*:*' menu yes select

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:*:(ssh|scp):*:*' hosts `sed 's/^\([^ ,]*\).*$/\1/' ~/.ssh/known_hosts`


# BINDINGS
bindkey -e

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

bindkey "\e\b" backward-delete-word

#bindkey "^Xh" _complete_help


# PROMPT

setopt prompt_subst
autoload -U promptinit; promptinit
prompt vitaly

if [[ -s ~/.rvm/scripts/rvm ]] ;then source ~/.rvm/scripts/rvm ;fi

#set -o vi
