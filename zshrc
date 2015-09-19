fpath=(~/.zsh/functions $fpath)

# ALIASES
alias .='pwd'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ls='ls -FG'
alias ll='ls -FGl'


function sc() {
    set -x
    if [ -f ./script/console ]; then
        ./script/console --debugger "$@"
    else
        if [ -f ./bin/rails ]; then
            ./bin/rails console --debugger "$@"
        else
            rails console --debugger "$@"
        fi
    fi
    set +x
}

function ss() {
    if [ -f ./script/server ]; then
        ./script/server --debugger "$@"
    else
        if [ -f ./script/rails ]; then
            ./script/rails server --debugger "$@"
        else
            rails server --debugger "$@"
        fi
    fi
}

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

# COLORS
autoload colors; colors;

export CLICOLOR=1
# colors:
#   a     black
#   b     red
#   c     green
#   d     brown
#   e     blue
#   f     magenta
#   g     cyan
#   h     light grey
#   A     bold black, usually shows up as dark grey
#   B     bold red
#   C     bold green
#   D     bold brown, usually shows up as yellow
#   E     bold blue
#   F     bold magenta
#   G     bold cyan
#   H     bold light grey; looks like bright white
#   x     default foreground or background
#
# order:
#   1.   directory
#   2.   symbolic link
#   3.   socket
#   4.   pipe
#   5.   executable
#   6.   block special
#   7.   character special
#   8.   executable with setuid bit set
#   9.   executable with setgid bit set
#   10.  directory writable to others, with sticky bit
#   11.  directory writable to others, without sticky bit

##                1   2   3   4   5   6   7   8   9   10  11
#export LSCOLORS="Gx""fx""cx""dx""bx""eg""ed""ab""ag""ac""ad"

#                1   2   3   4   5   6   7   8   9   10  11
export LSCOLORS="Ex""Fx""cx""dx""bx""eg""ed""ab""ag""ac""ad"


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
setopt auto_menu
unsetopt menu_complete

zmodload -i zsh/complist

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
zstyle ':completion:*:*:*:*:*' menu yes select

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:*:(ssh|scp):*:*' hosts `sed 's/^\([^ ,]*\).*$/\1/' ~/.ssh/known_hosts`

zstyle ':completion:*' insert-unambiguous true
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit; compinit

# PROMPT

setopt prompt_subst
autoload -U promptinit; promptinit
prompt fancy

# NVM
if [ -e ~/.nvm/nvm.sh ]; then
  source ~/.nvm/nvm.sh
fi

# RVM
if [[ -s /etc/profile.d/rvm.sh ]]; then
  source /etc/profile.d/rvm.sh
elif [[ -s ~/.rvm/scripts/rvm ]] ;then
 source ~/.rvm/scripts/rvm
elif [[ -s /usr/local/rvm/scripts/rvm ]] ;then
 source /usr/local/rvm/scripts/rvm
fi

# BINDINGS
#bindkey -e
bindkey -v

# Up
bindkey "\e[A" history-search-backward
# Down
bindkey "\e[B" history-search-forward

# PgUp. Fn-Shift-Up
bindkey "\e[5~" up-line-or-history
# PgDown. Fn-Shift-Down
bindkey "\e[6~" down-line-or-history

# Esc Backspace
#bindkey "\e\b" backward-delete-word
#bindkey "\e\b" vi-backward-kill-word

# home. Fn-Shift-Left on mac
bindkey "\e[H" beginning-of-line
# end. Fn-Shift-Right on mac
bindkey "\e[F" end-of-line

# Esc .
bindkey "\e." insert-last-word

# Ctrl-A
bindkey "^A" beginning-of-line
# Ctrl-E
bindkey "^E" end-of-line

# 'v' in vi command model to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

#bindkey "^Xh" _complete_help

if [ -e ~/.zsh/local ]; then
    source ~/.zsh/local
fi

function mm() { pwd > ~/.last_dir }
function gg() { cd "`cat ~/.last_dir`" }
function chpwd { mm }
gg
