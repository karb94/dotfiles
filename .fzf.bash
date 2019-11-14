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
      filenames=("$(fd --hidden --type f --no-ignore --exclude ".git" --max-depth 3 . $1 |
          ( [ -z "$1" ] && cat || sed "s/${1%/}\///" ) |
          fzf --multi)") && v ${1%/}/$filenames
    }

    c() {
      local dir
      dir=$(fd --hidden --type d --no-ignore --exclude ".git" --max-depth 3 . $1 |
          ( [ -z "$1" ] && cat || sed "s/${1%/}\///" ) |
          fzf --no-exact --no-multi) && cd "$dir" && ls
    }
    df() {
      local filename
      filename=$(fd --type f --hidden --maxdepth 3 -p "^$HOME/(\.[^/]*$|\.config)" $HOME |
          rg -o --color never "(\..*|\.config/.*)" | fzf --no-multi) &&
      v "$HOME/$filename"
    }
else
    vf() {
      local filenames
      filenames=("$(find ${1:-.} -type f -maxdepth 1 -print 2> /dev/null | fzf --multi)") &&
      v $filenames
    }

    c() {
      local dir
      dir=$(find * -maxdepth 3 -type d -print 2> /dev/null | fzf --no-exact --no-multi) &&
      cd "$dir"
      ls
    }
    df() {
      local filename
      filename=$(find $HOME -name '.*' -maxdepth 1 -print 2> /dev/null \
          | grep -o --color=never "\..*" | fzf --multi) &&
      v "$HOME/$filename"
    }
fi

# Adding more commands for completion
# ---------------------
complete -F _fzf_path_completion -o default -o bashdefault v

# Setting key bindings for the functions
bind '"\C-g":"c\r"'
bind '"\C-o":"vf\r"'
