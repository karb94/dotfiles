# set vi mode in command line. It needs to be at the top according to fzf
set -o vi

# Bash options
# After exiting append to history file instead of overwritting the file
# Not really useful if you append to history after each command (as we do below)
# shopt -s histappend
# include ** globbing pattern
# shopt -s globstar
# Add extended global patterns
shopt -s extglob
# Prevents messing up the screen after resizes
shopt -s checkwinsize
# Change directory without cd
# shopt -s autocd

test -f ~/.config/bash/fzf.bash && source $_
test -f ~/.config/bash/alias.bash && source $_
test -f ~/.config/bash/functions.bash && source $_

# Commands preceeded by a space are not added to history
# erasedups: only keep most recent copies of a command
# This is helpful to prevent useless fzf functions from being added to history
export HISTCONTROL=ignoreboth:erasedups
# Define your command prompt
red1='\033[38;5;1m'
green1='\033[38;5;2m'
blue1='\033[38;5;4m'
blue2='\033[38;5;12m'
aqua1='\033[38;5;6m'
aqua2='\033[38;5;14m'
yellow2='\033[38;5;11m'
orange1='\033[38;5;166m'
bold='\033[1m'
reset_font='\033[0m'

ssh_prompt () {
    [ -n "$SSH_CONNECTION" ] && printf "${yellow2}${HOSTNAME}${reset_font}" 
}

git_prompt () {
    local branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ "$branch_name" == 'HEAD' ]; then
        printf "${orange1}(detached ${branch_name})"
    elif [ -n "$branch_name" ]; then
        ( git diff --quiet HEAD && git diff --cached --quiet ) &&
           printf "${aqua2}(${branch_name})${reset_font}" ||
            printf "${red1}(${branch_name})${reset_font}"
    fi
}

export PS1="
\[\$(git_prompt)\$(ssh_prompt)${blue1}\]\u:\[${blue2}\]\w/
\[${bold}${aqua2}\]>\[${reset_font}\] "

# Prompt command
export PROMPT_COMMAND='
history -a
'

# Setting key bindings for the functions
stty -a | grep -q discard >/dev/null && stty discard undef
bind -m vi-insert -r "\ec"
bind -m vi-command -r "\ec"
# bind -x vi-insert -r "\ec"
bind -x $'"\C-k":ls;'


# For future use
# if [ "$(uname)" = "Linux" ]
