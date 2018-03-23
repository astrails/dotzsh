# vim: ft=zsh

fpath=(~/.zsh/functions $fpath)

# OPTIONS
export PAGER=less
export EDITOR=vim
export LANG=en_US.UTF-8
launchctl setenv LANG $LANG
export LC_ALL=en_US.UTF-8
launchctl setenv LC_ALL $LC_ALL

# source profile.d/*
while read f; do
  source ~/.zsh/profile.d/$f
done < <(\ls ~/.zsh/profile.d)
