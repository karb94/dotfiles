# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source extra configuration
[ -f $HOME/.config/bash/config.bash ] && source $HOME/.config/bash/config.bash 
