# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /opt/CRYSTAL17/utils17/cry17.bashrc 

# Source extra configuration
[ -f $HOME/.config/bash/config.bash ] && source $HOME/.config/bash/config.bash 

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/carles/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/carles/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/carles/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/carles/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias luamake=/home/carles/.local/builds/lua-language-server/3rd/luamake/luamake
