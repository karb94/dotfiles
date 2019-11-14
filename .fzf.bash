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
if [[ ! $HOSTNAME =~ login-[0-9]+ ]]
then
    export FZF_CTRL_T_COMMAND='fd --type f --hidden --no-ignore --exclude .git --max-depth 3'
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --max-depth 3'
fi
export FZF_DEFAULT_OPTS="--exact --layout=reverse --height 40% --select-1 --inline-info"

# Overwriting default functions
# ---------------------
if [[ ! $HOSTNAME =~ login-[0-9]+ ]]
then
    _fzf_compgen_path() {
      fd --type f --hidden --no-ignore --exclude ".git" --max-depth 3 . "$1"
    }

    _fzf_compgen_dir() {
      fd --type d --hidden --no-ignore --exclude ".git" --max-depth 3 . "$1"
    }

    vf() {
      local filenames
      filenames=("$(fd --type f --no-ignore --exclude ".git" --max-depth 1 ${1:-.} | fzf --multi)") &&
      v $filenames
    }

    cdf() {
      local dir
      local path
      # if [ -z "$1" ]
      # then
      #     path=""
      # else
      #     path=${1%/}/
      # fi
      dir=$(fd --type d --no-ignore --exclude ".git" --max-depth 3 . $1 \
          | ( [ -z "$1" ] && cat || sed "s/${1%/}\///" ) | fzf --no-exact --no-multi) &&
      cd "$dir" && ls
    }
    df() {
      local filename
      filename=$(fd --type f --hidden --maxdepth 1 "^\." $HOME \
          | rg -o --color never "\..*" | fzf --no-multi) &&
      v "$HOME/$filename"
    }
else
    vf() {
      local filenames
      filenames=("$(find ${1:-.} -type f -maxdepth 1 -print 2> /dev/null | fzf --multi)") &&
      v $filenames
    }

    cdf() {
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
bind '"\C-g":"cdf\r"'
bind '"\C-o":"vf\r"'
