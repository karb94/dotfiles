# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/carless/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/carless/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/carless/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/carless/.fzf/shell/key-bindings.bash"
