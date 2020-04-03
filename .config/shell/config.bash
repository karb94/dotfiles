set -o vi

[[ ":$PATH:" != *":~/.local/scripts/:"* ]] &&
PATH="${PATH}:~/.local/scripts/"

[[ ":$PATH:" != *":~/.local/bin/:"* ]] &&
PATH="${PATH}:~/.local/bin/"


command -v fzf >/dev/null 2>&1 && test -f ~/.config/shell/fzf.bash && source $_
# If git command doesn't exist don't source
if command -v git >/dev/null 2>&1
then
     test -f ~/.config/git/git-completion.bash && source $_
     test -f ~/.config/git/git-prompt.sh && source $_
fi
test -f ~/.config/shell/alias.bash && source $_

# Commands preceeded by a space are not added to history
# This is helpful to prevent useless fzf functions from being added to history
HISTCONTROL=ignorespace

# Prompt command configuration
shopt -s histappend
# if [ "$(uname)" = "Linux" ]
# then
# For Linux
config_sourced=$(stat -c %Y ~/.config/shell/config.bash)
PROMPT_COMMAND='
history -a
[ $(stat -c %Y ~/.config/shell/config.bash) -ne $config_sourced ] &&
    source ~/.config/shell/config.bash
[ $(stat -c %Y ~/.config/shell/alias.bash) -ne $alias_sourced ] &&
    source ~/.config/shell/alias.bash
printf "\n"
'
# else
#     # For MacOS
#     config_sourced=$(stat -f %m ~/.config/shell/config.bash)
#     alias_sourced=$(stat -f %m ~/.config/shell/alias.bash)
#     PROMPT_COMMAND='
#     history -a
#     [ $(stat -f %m ~/.config/shell/config.bash) -ne $config_sourced ] &&
#         source ~/.config/shell/config.bash
#     [ $(stat -f %m ~/.config/shell/alias.bash) -ne $config_sourced ] &&
#         source ~/.config/shell/alias.bash
#     printf "\n"
#     '
# fi

# Setting key bindings for the functions
stty -a | grep discard >/dev/null && stty discard undef
bind -m vi-insert -r "\ec"
bind -m vi-command -r "\ec"
bind -m vi-insert '"\C-b":"\C-[cccd ..\C-m"'
bind -m vi-command '"\C-b":"cccd ..\C-m"'
