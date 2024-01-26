test -f $HOME/.profile_extra && . $HOME/.profile_extra

test ${SHELL##*/} = 'bash' && test -f $HOME/.bashrc && . $HOME/.bashrc

# https://wiki.gentoo.org/wiki/Hyprland#On_login_with_tty
# Auto-start hyperland only in graphical tty
[ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR:-0}" -eq 1 ] && Hyprland > $HOME/.local/share/hyperland
