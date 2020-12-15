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

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
[ -x "$f" ] && . "$f"
done
unset f
fi

test -f $HOME/.local/scripts/tmux_init && . $HOME/.local/scripts/tmux_init

picom -CG &
xsetroot -cursor_name left_ptr &
unclutter --timeout 1 --ignore-scrolling &
dunst &
sxhkd -m -1 &
test -f $HOME/.local/share/X11/xkb/qwerty.xkb &&
        xkbcomp $HOME/.local/share/X11/xkb/qwerty.xkb $DISPLAY &
exec bspwm
# exec i3
