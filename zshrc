fpath=(~/.zsh/functions $fpath)

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
export LANG=en_US.UTF-8
launchctl setenv LANG $LANG
export LC_ALL=en_US.UTF-8
launchctl setenv LC_ALL $LC_ALL
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
zstyle ':completion:*:*:*:*:*' menu yes select

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

if [ -e ~/.ssh/known_hosts ]; then
  zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
  zstyle ':completion:*:*:(ssh|scp):*:*' hosts `sed 's/^\([^ ,]*\).*$/\1/' ~/.ssh/known_hosts`
fi

zstyle ':completion:*' insert-unambiguous true
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit; compinit

# PROMPT

setopt prompt_subst
autoload -U promptinit; promptinit
prompt fancy

source ~/.zsh/config/aws.sh
source ~/.zsh/config/colors.sh
source ~/.zsh/config/nvm.sh
source ~/.zsh/config/bindings.sh
source ~/.zsh/config/aliases.sh
source ~/.zsh/config/chruby.sh
source ~/.zsh/config/dirs.sh

# source ~/.zsh/config/iterm.sh

while read f; do
  source ~/.zsh/config.d/$f
done < <(\ls ~/.zsh/config.d)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
