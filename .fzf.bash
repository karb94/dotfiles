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
    export FZF_CTRL_T_COMMAND='fd --type f --hidden --no-ignore --exclude .git --max-depth 3'
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --max-depth 3'
fi
export FZF_DEFAULT_OPTS="--exact --layout=reverse --height 40% --select-1 --inline-info"

# Overwriting default functions
# ---------------------
# if [[ ! $HOSTNAME =~ login-[0-9]+ ]]
if command -v fd >/dev/null 2>&1
then
    _fzf_compgen_path() {
        fd --type f --hidden --no-ignore --exclude ".git" --max-depth 3 . "$1"
    }

    _fzf_compgen_dir() {
        fd --type d --hidden --no-ignore --exclude ".git" --max-depth 3 . "$1"
    }

    vf() {
        local filenames
        filenames=("$(fd --hidden --type f --no-ignore --exclude ".git" --max-depth 3 . "${1:-.}" 2> /dev/null |
            ( [ -z "$1" ] && cat || sed "s,${1%/}/,," ) |
            fzf --multi)") && [ -z "$1" ] &&
            v "${filenames}" || v "${1%/}/${filenames}"
        }

    d() {
        local dir
        dir=$(fd --hidden --type d --no-ignore --exclude ".git" --max-depth 3 . "${1:-.}" 2> /dev/null |
            ( [ -z "$1" ] && cat || sed "s,${1%/}/,," ) |
            fzf --no-exact --no-multi) && { [ -z "$1" ] &&
            cd "${dir}" || cd "${1%/}/${dir}" && ls; }
        }
    df() {
        local filename
        filename=$(fd --type f --hidden --maxdepth 3 -p "^$HOME/(\.[^/]*$|\.config)" $HOME |
            rg -o --color never "(\..*|\.config/.*)" |
            fzf --no-multi) &&
            v "$HOME/$filename"
    }
else
    vf() {
        local filenames
        local path="${1%/}"
        filenames=("$(find ${path:-.} -type f -maxdepth 3 -print 2> /dev/null |
            ( [ -z "$path" ] && cat || sed "s,${path}/,," ) | fzf --multi)") &&
            [ -z "$1" ] && v "${filenames}" || v "${1%/}/${filenames}"
        }

    d() {
        local dir
        local path="${1%/}"
        dir=$(find ${path:-.} -maxdepth 3 -type d -print 2> /dev/null |
            ( [ -z "$path" ] && cat || sed "s,${path}/,," ) |
            fzf --no-exact --no-multi) && { [ -z "$1" ] &&
            cd "${dir}" || cd "${1%/}/${dir}" && ls; }
        }
    df() {
        local filename
        filename=$(find -E $HOME -type f -regex "^$HOME/(\.[^/]*$|\.config\/.*$)" \
            -maxdepth 3 -print 2> /dev/null |
            grep -E -o --color=never "(\..*|\.config/.*)" |
            fzf --multi) && v "$HOME/$filename"
        }
fi

# Adding more commands for completion
# ---------------------
complete -F _fzf_path_completion -o default -o bashdefault v

# Setting key bindings for the functions
stty discard undef
stty dsusp undef
bind -m vi-insert -r "\ec"
bind -m vi-command -r "\ec"
bind -m vi-insert '"\C-g":"\C-[ccd\C-m"'
bind -m vi-command '"\C-g":"ccd\C-m"'
bind -m vi-insert '"\C-o":"\C-[ccvf\C-m"'
bind -m vi-command '"\C-o":"ccvf\C-m"'
bind '"\C-o":"\eccvf\r"'
