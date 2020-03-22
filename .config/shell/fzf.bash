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
export FZF_DEFAULT_OPTS="--exact --layout=reverse --height 40% --select-1 --inline-info"

# Overwriting default functions
# ---------------------
# if [[ ! $HOSTNAME =~ login-[0-9]+ ]]
if command -v fd >/dev/null 2>&1
then
    _fzf_compgen_path() {
        fd --type f --hidden --no-ignore --exclude ".git"  . "$1"
    }

    _fzf_compgen_dir() {
        fd --type d --hidden --no-ignore --exclude ".git" . "$1"
    }

    vf() {
        local filenames
        mapfile -t filenames < <( fd --hidden --type f --no-ignore --exclude ".git" --max-depth 3 . "${1:-.}" 2> /dev/null |
            ( [ -z "$1" ] && cat || sed "s,${1%/}/,," ) | fzf --multi )
                    #tr '\n' ' ')" )
        if [ -n "${filenames[0]}" ]
        then
            if [ -n "$1" ] 
            then
                if [ "${#filenames[@]}" -gt 1 ]
                then
                    v -O2 "${filenames[@]/#/${1%/}/}" 
                    history -s v -O2 "${filenames[@]/#/${1%/}/}" 
                else
                    v "${1%/}/${filenames}" 
                    history -s v "${1%/}/${filenames}" 
                fi
            else
                if [ "${#filenames[@]}" -gt 1 ]
                then
                    v -O2 "${filenames[@]}"
                    history -s v -O2 "${filenames[@]}"
                else
                    v ${filenames}
                    history -s v ${filenames}
                fi
            fi
        fi
        }

    d() {
        local dir
        dir=$(fd --hidden --type d --no-ignore --exclude ".git" --max-depth 3 . "${1:-.}" 2> /dev/null |
            ( [ -z "$1" ] && cat || sed "s,${1%/}/,," ) |
            fzf --no-exact --no-multi)
        if [ -n "$dir" ]
        then
            clear
            if [ -z "$1" ]
            then
                cd "${dir}" && ls --group-directories-first -prt --color=auto
                history -s cd "${dir}"
            else
                cd "${1%/}/${dir}" && ls --group-directories-first -prt --color=auto
                history -s cd "${1%/}/${dir}"
            fi
        fi
        }
    df() {
        local filename
        mapfile -t filenames < <( fd --hidden --type f --exclude ".git" \
            --max-depth 3 -p "^$HOME/(\.[^/]*$|\.config|\.vim)" $HOME |
            rg -o --color never "(\..*|\.config/.*)" | fzf --multi )
        if [ -n "${filenames[0]}" ] 
        then
            if [ "${#filenames[@]}" -gt 1 ]
            then
                v -O2 "${filenames[@]/#/~/}"
                history -s v -O2 "${filenames[@]/#/'~'/}"
            else
                v "${filenames[@]/#/~/}"
                history -s v "${filenames[@]/#/'~'/}"
            fi
        fi
    }
else
    vf() {
        local filenames
        local path="${1%/}"
        filenames=( "$(find ${path:-.} -type f -maxdepth 4 -print 2> /dev/null |
            ( [ -z "$path" ] && cat || sed "s,${path}/,," ) | fzf --multi | tr '\n' ' ')" )
        [ -n "$1" ] && v "${1%/}/${filenames}" || [ -n "${filenames[0]}" ] && v "${filenames}"
        }

    d() {
        local dir
        local path="${1%/}"
        dir=$(find ${path:-.} -maxdepth 4 -type d -print 2> /dev/null |
            ( [ -z "$path" ] && cat || sed "s,${path}/,," ) |
            fzf --no-exact --no-multi) && { [ -z "$1" ] &&
            cd "${dir}" || cd "${1%/}/${dir}" && ls -pG --color=auto; }
        }
    df() {
        local filename
        filename=$(find -E $HOME -type f -regex "^$HOME/(\.[^/]*$|\.config\/.*$|\.vim\/.*$)" \
            -maxdepth 3 -print 2> /dev/null |
            grep -E -o --color=never "(\..*|\.config/.*)" |
            fzf --multi) && v "$HOME/$filename"
        }
fi

# Adding more commands for completion
# ---------------------
complete -F _fzf_path_completion -o default -o bashdefault v