# set vi mode in command line. It needs to be at the top according to fzf
# set -o vi

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

# Completions
complete -c doas

test -f ~/.config/bash/fzf.bash && source $_
test -f ~/.config/bash/alias.bash && source $_
test -f ~/.config/bash/functions.bash && source $_

eval "$(zoxide init bash)"

# Commands preceeded by a space are not added to history
# erasedups: only keep most recent copies of a command
# This is helpful to prevent useless fzf functions from being added to history
export HISTCONTROL=ignoreboth:erasedups

export HISTFILE="$HOME/.local/share/bash/history"
export HISTSIZE=10000
export HISTFILESIZE=10000
mkdir -pv $(dirname "$HISTFILE")

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
    local branch_name
    branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    [ -z "$branch_name" ] && return

    if [ "$branch_name" == 'HEAD' ]; then
      printf '%b(detached %s)' "${orange1}" "${branch_name}"
      return
    fi

    local large_repo_names repo_name uncolored_prompt
    large_repo_names=( "nixpkgs" "qmk_firmware" )
    repo_url=$(git config --get remote.origin.url)
    repo_name=$(basename "$repo_url" .git)
    uncolored_prompt=$(printf '(%s)%b' "${branch_name}" "${reset_font}")
    # If it's a large repo don't run git diff
    if [[ "${large_repo_names[*]}" =~ (^|[[:space:]])${repo_name}($|[[:space:]]) ]]; then
      printf '%b%s' "${yellow2}" "$uncolored_prompt"
      return
    fi

    if { git diff --quiet HEAD && git diff --cached --quiet; }; then
      printf '%b%s' "${aqua2}" "$uncolored_prompt"
    else
      printf '%b%s' "${red1}" "$uncolored_prompt"
    fi
}

export PS1="
\[\$(git_prompt)\$(ssh_prompt)${blue1}\]\u:\[${blue2}\]\w/
\[${bold}${aqua2}\]>\[${reset_font}\] "

# Prompt command
# export PROMPT_COMMAND="
# history -a;${PROMPT_COMMAND#;}
# "

# Setting key bindings for the functions
stty -a | grep -q discard >/dev/null && stty discard undef
# bind -m vi-insert -r "\ec"
# bind -m vi-command -r "\ec"
# bind -x vi-insert -r "\ec"
bind -x $'"\C-k":ls;'
# Ctrl-s is used to stop (pause) the output of a command
# Unbind to bind it to something else
stty stop undef
# Delete first word
bind -m emacs '"\C-s":"\C-a\033f\C-u"'
bind -m emacs '"\C-g":"\C-e\C-uzi\C-m"'
bind -m emacs '"\C-b":"\C-e\C-ucd ..\C-m"'
# bind -m vi-insert '"\C-g":"\C-[cczi\C-m"'
# bind -m vi-command '"\C-g":"cczi\C-m"'
