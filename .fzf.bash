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
export FZF_CTRL_T_COMMAND='fd --type f --hidden --no-ignore --exclude .git --max-depth 4'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --max-depth 4'
export FZF_DEFAULT_OPTS="--exact --layout=reverse --inline-info"

# Overwriting default functions
# ---------------------
_fzf_compgen_path() {
  fd --type f --hidden --no-ignore --exclude ".git" --max-depth 4 . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --no-ignore --exclude ".git" --max-depth 4 . "$1"
}

# Adding more commands for completion
# ---------------------
complete -F _fzf_path_completion -o default -o bashdefault v
