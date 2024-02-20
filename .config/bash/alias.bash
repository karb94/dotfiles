
#            $$$$$$\    $$\        $$$$$$\    $$$$$$\     $$$$$$\  
#           $$  __$$\   $$ |       \_$$  _|  $$  __$$\   $$  __$$\ 
#           $$ /  $$ |  $$ |         $$ |    $$ /  $$ |  $$ /  \__|
#           $$$$$$$$ |  $$ |         $$ |    $$$$$$$$ |  \$$$$$$\  
#           $$  __$$ |  $$ |         $$ |    $$  __$$ |   \____$$\ 
#           $$ |  $$ |  $$ |         $$ |    $$ |  $$ |  $$\   $$ |
#           $$ |  $$ |  $$$$$$$$\  $$$$$$\   $$ |  $$ |  \$$$$$$  |
#           \__|  \__|  \________| \______|  \__|  \__|   \______/ 


# Source complete_alias
. complete_alias

# Source bashrc
alias sb='source ~/.bashrc'

# Built-ins
alias ds='doas '
alias ll='eza --long --reverse --time=modified --color=auto --group-directories-first' 
# alias ls='\ls -prt --color=auto --group-directories-first' 
alias ls='eza --reverse --time=modified --color=auto --group-directories-first'
alias lsh='eza -A --color=auto | grep "^\."'
alias mkdir='mkdir -v' 
alias rv='rm -Iv' 
alias mv='mv -iv' 
alias cp='cp -iv' 
alias grep='grep --color=auto'
alias sd='pkill brave; pkill alacritty; setsid systemctl poweroff'

# Editing
alias e='$EDITOR'
alias se='sudo -E $EDITOR'
alias es='$EDITOR -S Session.vim'
alias eb='$EDITOR ~/.config/bash/config.bash'
alias eal='$EDITOR ~/.config/bash/alias.bash'
alias efu='$EDITOR ~/.config/bash/functions.bash'
alias ep="nvim -i NONE -u NONE -U NONE -n -c 'set nomodeline'"

# NixOS
alias rb='doas nixos-rebuild'
complete -W "test switch build boot" rb
alias gc='doas nix-collect-garbage -d'
alias nfu='nix flake update'

# Open files
alias j='echo jupyter && setsid -f jupyter lab > /dev/null 2>&1 &'
alias feh='feh --scale-down --auto-zoom'
alias p='$PAGER'

# Navigation
alias h='cd $HOME' 
alias cfg='$HOME/.config'

# Environments
alias ac='conda activate'
alias da='conda deactivate'
alias ae='. env/bin/activate'
alias de='deactivate'
alias vml='qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -m 2048 \
  -usb -device usb-tablet \
  -device virtio-vga-gl \
  -boot order=cd \
  -display gtk,gl=on \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/ovmf/x64/OVMF.fd \
  -drive if=pflash,format=raw,readonly=on,file=OVMF_VARS.fd \
  -cdrom $HOME/data/archiso/archlinux-2022.*-x86_64.iso \
  -drive format=raw,cache=none,file=$HOME/data/archiso/ssd.raw'
alias vm='qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -m 2048 \
  -device virtio-vga-gl \
  -display gtk,gl=on \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/ovmf/x64/OVMF.fd \
  -drive if=pflash,format=raw,readonly=on,file=OVMF_VARS.fd \
  -drive format=raw,cache=none,file=$HOME/data/archiso/ssd.raw'

# Network connections
alias q='qstat -u cr216'
alias cx1='ssh -t cx1 "~/usr/local/bin/bash -l"'
alias nhpc='ssh carles@nhpc16.ch.ic.ac.uk'
alias vpn='nmcli connection up --ask ic'

# Miscellaneous
alias nb='newsboat --quiet'
alias btm='btm -bg --mem_as_value'
alias al='setsid alacritty --working-directory $(pwd)'

# Git
alias g='git'
test -f ~/.config/git/git-completion.bash && source $_
__git_complete g __git_main
