test -f $HOME/.profile_extra && . $HOME/.profile_extra

export VDPAU_DRIVER=va_gl

if [ -e /home/carles/.nix-profile/etc/profile.d/nix.sh ]; then . /home/carles/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

startx > /dev/null 2>&1
