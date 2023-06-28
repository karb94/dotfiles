test -f $HOME/.profile_extra && . $HOME/.profile_extra

test ${SHELL##*/} = 'bash' && test -f $HOME/.bashrc && . $HOME/.bashrc

if command -v wob >/dev/null 2>&1; then
  fifo_path="$HOME"/.local/fifo/wob_volume
  if [ ! -p "$HOME"/.local/fifo/wob_volume ]; then
    mkdir -p $(dirname "$fifo_path")
    mkfifo "$fifo_path"
  fi
  ( tail -f "$fifo_path" | wob -s volume >/dev/null 2>&1 & )
fi

Hyprland > /dev/null 2>&1
