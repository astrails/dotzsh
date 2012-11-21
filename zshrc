fpath=(~/.zsh/functions $fpath)

# ALIASES
alias .='pwd'
alias ...='cd ../..'
alias ....='cd ../../..'

alias g='git'

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

alias sd="if [ -f ./script/dbconsole ]; then ./script/dbconsole; else rails db; fi"
alias s3=/usr/local/s3cmd/s3cmd
alias rd="rdebug -c"

alias :e=vim

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

function rake() {
  if [ -e bin/rake ]; then
      bin/rake "$@"
  else
      /usr/bin/env rake "$@"
  fi
}

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

# RVM
if [[ -s /etc/profile.d/rvm.sh ]]; then
  source /etc/profile.d/rvm.sh
elif [[ -s ~/.rvm/scripts/rvm ]] ;then
 source ~/.rvm/scripts/rvm
elif [[ -s /usr/local/rvm/scripts/rvm ]] ;then
 source /usr/local/rvm/scripts/rvm
fi

# BINDINGS
bindkey -v                                          # Use vi key bindings

bindkey '\ew' kill-region                           # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                             # [Esc-l] - run command: ls
bindkey -s '\e.' '..\n'                             # [Esc-.] - run command: .. (up directory)
bindkey '^r' history-incremental-search-backward    # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey '^[[5~' up-line-or-history                  # [PageUp] - Up a line of history
bindkey '^[[6~' down-line-or-history                # [PageDown] - Down a line of history

bindkey '^[[A' up-line-or-search                    # start typing + [Up-Arrow] - fuzzy find history forward
bindkey '^[[B' down-line-or-search                  # start typing + [Down-Arrow] - fuzzy find history backward

bindkey '^[[H' beginning-of-line                    # [Home] - Go to beginning of line
bindkey '^[[1~' beginning-of-line                   # [Home] - Go to beginning of line
bindkey '^[OH' beginning-of-line                    # [Home] - Go to beginning of line
bindkey '^[[F'  end-of-line                         # [End] - Go to end of line
bindkey '^[[4~' end-of-line                         # [End] - Go to end of line
bindkey '^[OF' end-of-line                          # [End] - Go to end of line

# emacs style
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

bindkey ' ' magic-space                             # [Space] - do history expansion

bindkey '^[[1;5C' forward-word                      # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                     # [Ctrl-LeftArrow] - move backward one word

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char                   # [Delete] - delete backward
bindkey '^[[3~' delete-char                         # [fn-Delete] - delete forward
bindkey '^[3;5~' delete-char
bindkey '\e[3~' delete-char


if [ -e ~/.zsh/local ]; then
    source ~/.zsh/local
fi

function mm() { pwd > ~/.last_dir }
function gg() { cd "`cat ~/.last_dir`" }

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

PATH=$PATH:/usr/local/rvm/bin # Add RVM to PATH for scripting
