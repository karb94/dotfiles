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
export FZF_DEFAULT_OPTS="--exact --layout=reverse --inline-info"

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
fi

# Adding more commands for completion
# ---------------------
complete -F _fzf_path_completion -o default -o bashdefault v
