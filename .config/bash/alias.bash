
#            $$$$$$\    $$\        $$$$$$\    $$$$$$\     $$$$$$\  
#           $$  __$$\   $$ |       \_$$  _|  $$  __$$\   $$  __$$\ 
#           $$ /  $$ |  $$ |         $$ |    $$ /  $$ |  $$ /  \__|
#           $$$$$$$$ |  $$ |         $$ |    $$$$$$$$ |  \$$$$$$\  
#           $$  __$$ |  $$ |         $$ |    $$  __$$ |   \____$$\ 
#           $$ |  $$ |  $$ |         $$ |    $$ |  $$ |  $$\   $$ |
#           $$ |  $$ |  $$$$$$$$\  $$$$$$\   $$ |  $$ |  \$$$$$$  |
#           \__|  \__|  \________| \______|  \__|  \__|   \______/ 

# Source bashrc
alias sb='source ~/.bashrc'

# Built-ins
alias ls='\ls -pGrt --color=auto --group-directories-first' 
alias lsh='ls -d .*'
alias mkdir='mkdir -v' 
alias rv='rm -Iv' 
alias mv='mv -iv' 
alias cp='cp -iv' 
alias grep='grep --color=auto'
alias sd='shutdown 0'

# Editing
alias e='$EDITOR'
alias se='sudo -E $EDITOR'
alias es='$EDITOR -S Session.vim'
alias eb='$EDITOR ~/.config/bash/config.bash'
alias eal='$EDITOR ~/.config/bash/alias.bash'
alias efu='$EDITOR ~/.config/bash/functions.bash'
alias vrc='$EDITOR ~/.vim/vimrc'
alias nvrc='$EDITOR ~/.config/nvim/init.vim'
alias ep="nvim -i NONE -u NONE -U NONE -n -c 'set nomodeline'"

# Package manager
alias pm='pacman'
alias sp='sudo pacman'
alias ud='sudo pacman -Syu'
alias pi="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pu="pacman -Qeq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rsn"
alias ai="aur pkglist | fzf --multi --preview 'aur search -v {1}' | xargs -ro aur sync -c"
alias ar="aur pkglist | fzf --multi --preview 'aur search -v {1}' | xargs -ro aur sync -c"
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'

# Open files
alias j='echo jupyter && setsid -f jupyter lab > /dev/null 2>&1 &'
alias feh='feh --scale-down --auto-zoom'
alias p='$PAGER'

# Navigation
alias h='cd $HOME' 
alias cfg='$HOME/.config'

# Environments
alias ds='conda activate data_science'
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
  -cdrom $HOME/projects/archiso/archlinux-2021.10.27-x86_64.iso \
  -drive format=raw,cache=none,file=$HOME/projects/archiso/ssd.raw'
alias vm='qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -m 2048 \
  -usb -device usb-tablet \
  -boot order=cd \
  -device virtio-vga-gl \
  -display gtk,gl=on \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/ovmf/x64/OVMF.fd \
  -drive if=pflash,format=raw,readonly=on,file=OVMF_VARS.fd \
  -drive format=raw,cache=none,file=$HOME/projects/archiso/ssd.raw'

# Network connections
alias q='qstat -u cr216'
alias cx1='ssh -t cx1 "~/usr/local/bin/bash -l"'
alias nhpc='ssh carles@nhpc16.ch.ic.ac.uk'
alias vpn='nmcli connection up --ask ic'

# Tmux
alias ta='tmux attach'
alias tk='tmux kill-server'

# Miscellaneous
alias nb='newsboat --quiet'

# DFT
alias etot='grep ETOT'
alias spin='grep SUMMED'
alias cy='grep "MAX G" -A3'
alias en='grep "TOTAL EN"'
alias coor='grep "ALPHA" -A1'
alias conv='grep "OPT END"'
alias rgui='conda run -n ase read_gui.py'
alias qp="qstat -f | sed -n '/Output/ {s/.*WORK//; N; s/\n\s*//; s/\.o[0-9]*\s*$/.out/; p}' | sort"

# Git
command -v git >/dev/null 2>&1 && alias g='git' &&
    test -f ~/.config/git/git-completion.bash && source $_

# CX1
if [[ $HOSTNAME =~ login-[0-9]+ ]]
then
    alias v='~/usr/local/bin/vim -Nu $HOME/.vim/minimal.vim'
    alias a='availability'
    alias eph="cd $EPHEMERAL"
    alias q='qstat -a'
    alias vsub='vi ~/bin/sub'
    alias lsout='ls *.out'
fi

# if [ $(uname) == "Linux" ]
# fi
