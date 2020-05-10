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
blue1='\033[38;5;4m'
blue2='\033[38;5;12m'
red1='\033[38;5;6m'
yellow2='\033[38;5;11m'
green2='\033[38;5;14m'
bold='\033[1m'          # Makes following text bold
reset_font='\033[0m'    # Applies default font attributes
ssh_prompt () {
    [ -n "$SSH_CONNECTION" ] &&
        printf "${yellow2}${HOSTNAME}${reset_font}" 
}
PS1="
\[$(ssh_prompt)${blue1}\]\u:\[${blue2}\]\w/
 \[${bold}${green2}\]>\[${reset_font}\] "

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
# bind -x vi-insert -r "\ec"
bind -x $'"\C-k":ls;'
bind -x $'"\C-k":ls;'


# For future use
# if [ "$(uname)" = "Linux" ]
