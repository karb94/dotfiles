# General variables
export LANG="en_GB.utf8"
export TERMINAL=kitty
export EDITOR=nvim
export PAGER=less

# Default XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# Add to path functions
append_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
prepend_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

# Add to path
prepend_to_path "$HOME/.local/bin"
prepend_to_path "$HOME/.local/scripts"

# Start window manager
# startx > /dev/null 2>&1
