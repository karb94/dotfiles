# set vi mode in command line. It needs to be at the top according to fzf
set -o vi

# Commands preceeded by a space are not added to history
# This is helpful to prevent useless fzf functions from being added to history
HISTCONTROL=ignorespace

# Append to history file after each command?
shopt -s histappend
# include ** globbing pattern
shopt -s globstar
# Change directory without cd
shopt -s autocd


[[ ":$PATH:" != *":~/.local/scripts/:"* ]] &&
PATH="${PATH}:~/.local/scripts/"

[[ ":$PATH:" != *":~/.local/bin/:"* ]] &&
PATH="${PATH}:~/.local/bin/"


test -f ~/.config/shell/fzf.bash && source $_
test -f ~/.config/shell/alias.bash && source $_

# Prompt command configuration
PROMPT_COMMAND='
    history -a
    printf "\n"
'
# Setting key bindings for the functions
stty -a | grep -q discard >/dev/null && stty discard undef
bind -m vi-insert -r "\ec"
bind -m vi-command -r "\ec"
bind -m vi-insert '"\C-b":"\C-[cccd ..\C-m"'
bind -m vi-command '"\C-b":"cccd ..\C-m"'

# For future use
# if [ "$(uname)" = "Linux" ]
