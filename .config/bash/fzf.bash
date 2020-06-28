# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}~/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.bash"

# Overwriting default commands and options
# ---------------------
# if [[ ! $HOSTNAME =~ login-[0-9]+ ]]
if command -v fd >/dev/null 2>&1
then
    export FZF_CTRL_T_COMMAND='fd --type f --hidden --no-ignore --exclude .git'
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --no-ignore --exclude .git'
fi
export FZF_DEFAULT_OPTS='
--layout=reverse --height 40% --select-1 --inline-info
--color=bg+:239'

# Overwriting default functions
# ---------------------
vf() {
    local filenames
    local path="${1%/}"
    mapfile -t filenames < <( find ${path:-.} -type f -maxdepth 5 -printf '%P\n' 2> /dev/null |
        fzf --multi )
    if [ -n "${filenames[0]}" ]
    then
        if [ -n "$1" ] 
        then
            if [ "${#filenames[@]}" -gt 1 ]
            then
                $EDITOR -O2 "${filenames[@]/#/${1%/}/}" 
                history -s $EDITOR -O2 "${filenames[@]/#/${1%/}/}" 
            else
                $EDITOR "${1%/}/${filenames}" 
                history -s $EDITOR "${1%/}/${filenames}" 
            fi
        else
            if [ "${#filenames[@]}" -gt 1 ]
            then
                $EDITOR -O2 "${filenames[@]}"
                history -s $EDITOR -O2 "${filenames[@]}"
            else
                $EDITOR ${filenames}
                history -s $EDITOR ${filenames}
            fi
        fi
    fi
    }

d() {
    local dir
    # strip forward slash from the end if it has it 
    local path="${1%/}"
    dir=$(find ${path:-.} -type d -mindepth 1 -maxdepth 5 \
            -name '.*' -prune \
            -o -type d -printf '%P\n' 2> /dev/null |
        # ( [ -z "$1" ] && cat || sed "s,${path}/,," ) |
        fzf --no-exact --no-multi)
    if [ -n "$dir" ]
    then
        clear
        if [ -z "$path" ]
        then
            cd "${dir}" && ls --group-directories-first -prt --color=auto
            history -s cd "${dir}"
        else
            cd "$path/${dir}" && ls --group-directories-first -prt --color=auto
            history -s cd "$path/${dir}"
        fi
    fi
    # local dir
    # dir=$(fd --hidden --type d --no-ignore --exclude ".git" --max-depth 3 . "${1:-.}" 2> /dev/null |
    #     ( [ -z "$1" ] && cat || sed "s,${1%/}/,," ) |
    #     fzf --no-exact --no-multi)
    }
cf() {
    # Only files at least 2 directories deep
    # Only hidden files in $HOME
    local filename
    mapfile -t filenames < <( find $HOME -mindepth 1 -type d \
            ! \( \( -path "$HOME/.config*" -a ! -path "$HOME/.config/*/*" \) \
                -o -path "$HOME/.$EDITOR" \
                -o -path "$HOME/.local" \
                -o -path "$HOME/.local/scripts" \) \
            -prune \
            -o -type f -path "$HOME/*/*" -printf '%P\n' \
            -o -type f -name ".*" -printf '%P\n' |
        fzf --multi )
    if [ -n "${filenames[0]}" ] 
    then
        if [ "${#filenames[@]}" -gt 1 ]
        then
            $EDITOR -O2 "${filenames[@]/#/~/}"
            history -s $EDITOR -O2 "${filenames[@]/#/'~'/}"
        else
            $EDITOR "${filenames[@]/#/~/}"
            history -s $EDITOR "${filenames[@]/#/'~'/}"
        fi
    fi
}

# Adding more commands for completion
# ---------------------
complete -F _fzf_path_completion -o default -o bashdefault v

# Setting key bindings for the functions
# bind -m vi-insert '"\C-o":"\C-[ccvf\C-m"'
# bind -m vi-command '"\C-o":"ccvf\C-m"'
bind -m vi-insert '"\C-g":"\C-[ccd\C-m"'
bind -m vi-command '"\C-g":"ccd\C-m"'
