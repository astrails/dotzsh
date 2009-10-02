# ALIASES
alias .='pwd'
alias ...='cd ../..'

alias g='git'

alias ls='ls -FG'

alias sc=./script/console
alias ss=./script/server
alias s3=/aws/s3cmd/s3cmd

function mh()
{
	pwd > ~/.hd
}
alias mm=mh

function gh()
{
	cd `cat ~/.hd`
}
alias gg=gh



alias KA='~/Pictures/Archive/organizr/bin/organizr archive -a /Users/vitaly/Desktop/Kati/indexed-archive'



# COLORS
autoload colors; colors;

unset LSCOLORS
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
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
setopt autocd
setopt extendedglob

# OPTIONS
export PAGER=less
export LC_CTYPE=en_US.UTF-8

unsetopt beep nomatch

setopt auto_name_dirs
setopt auto_cd
setopt multios
setopt cdablevars

autoload -U select-word-style
select-word-style bash


# COMPLETION
# zstyle ':completion:*' completer ''
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' max-errors 1
# zstyle ':completion:*' menu select=1
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle :compinstall filename '/home/astrails/.zshrc'

autoload -Uz compinit
compinit

unsetopt menu_complete
setopt auto_menu

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


# PROMPT
# get the name of the branch we are on
function git_prompt_info() {
  if [[ -d .git ]]; then
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    branch=${ref#refs/heads/}
    CURRENT_BRANCH="git:(%{$fg[red]%}${branch}%{$fg[blue]%})%{$reset_color%}$(parse_git_dirty)"
  else
    CURRENT_BRANCH=''
  fi

  echo $CURRENT_BRANCH
}

parse_git_dirty () {
  [[ $(git status | tail -n1) != "nothing to commit (working directory clean)" ]] && echo " %{$fg[yellow]%}✗%{$reset_color%}"
}

parse_git_branch ()
{
    git branch --no-color 2> /dev/null | gsed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

setopt prompt_subst
# PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(parse_git_branch)%{$fg_bold[blue]%} % %{$reset_color%} ✗ '
