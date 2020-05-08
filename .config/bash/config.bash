# set vi mode in command line. It needs to be at the top according to fzf
set -o vi

# Commands preceeded by a space are not added to history
# This is helpful to prevent useless fzf functions from being added to history
HISTCONTROL=ignoreboth

# Bash options
# Append to history file after each command?
shopt -s histappend
# include ** globbing pattern
shopt -s globstar
# Add extended global patterns
shopt -s extglob
# Change directory without cd
# shopt -s autocd

# Define your command prompt
color4='\033[38;5;4m'   # Blue1
color12='\033[38;5;12m' # Blue2
color14='\033[38;5;14m' # Green2
bold='\033[1m'          # Makes following text bold
reset_font='\033[0m'    # Applies default font attributes
PS1="
${color4}\u:${color12}\w/
${bold}${color14}>${reset_font} "

# Prompt command
PROMPT_COMMAND='
    history -a
'

test -f ~/.config/bash/fzf.bash && source $_
test -f ~/.config/bash/alias.bash && source $_
test -f ~/.config/bash/functions.bash && source $_

# Setting key bindings for the functions
stty -a | grep -q discard >/dev/null && stty discard undef
bind -m vi-insert -r "\ec"
bind -m vi-command -r "\ec"
bind -m vi-insert '"\C-b":"\C-[cccd ..\C-m"'
bind -m vi-command '"\C-b":"cccd ..\C-m"'

# For future use
# if [ "$(uname)" = "Linux" ]
