test -f $HOME/.profile_extra && . $HOME/.profile_extra

test ${SHELL##*/} = 'bash' && test -f $HOME/.profile_extra && . $HOME/.profile_extra

# startx > /dev/null 2>&1