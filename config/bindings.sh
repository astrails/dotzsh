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
