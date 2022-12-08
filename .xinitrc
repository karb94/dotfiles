#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# xsetroot -cursor_name left_ptr solves problem with "cross" cursor
picom -CG &
# Fix cross cursor issue
xsetroot -cursor_name left_ptr &
# # set background
hsetroot -solid "#000000" &
# # Hide cursor after 1 second of inactivity
unclutter --timeout 1 --ignore-scrolling &
# # Notifications daemon
dunst &
# [ -f $HOME/.local/scripts/tmux_init ] &&
#     $HOME/.local/scripts/tmux_init &
# Volume bar
command -v xob >/dev/null 2>&1 && [ -p "$HOME"/.local/fifo/xob_volume ] &&
  ( tail -f "$HOME"/.local/fifo/xob_volume | xob -s volume >/dev/null 2>&1 & )

sxhkd -m -1 &
# test -f $HOME/.local/share/X11/xkb/qwerty.xkb &&
#   xkbcomp $HOME/.local/share/X11/xkb/qwerty.xkb $DISPLAY &
exec bspwm
