test -f $HOME/.profile_extra && . $HOME/.profile_extra

test ${SHELL##*/} = 'bash' && test -f $HOME/.bashrc && . $HOME/.bashrc

exec Hyprland > /dev/null 2>&1
