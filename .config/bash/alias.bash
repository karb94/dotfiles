
#            $$$$$$\    $$\        $$$$$$\    $$$$$$\     $$$$$$\  
#           $$  __$$\   $$ |       \_$$  _|  $$  __$$\   $$  __$$\ 
#           $$ /  $$ |  $$ |         $$ |    $$ /  $$ |  $$ /  \__|
#           $$$$$$$$ |  $$ |         $$ |    $$$$$$$$ |  \$$$$$$\  
#           $$  __$$ |  $$ |         $$ |    $$  __$$ |   \____$$\ 
#           $$ |  $$ |  $$ |         $$ |    $$ |  $$ |  $$\   $$ |
#           $$ |  $$ |  $$$$$$$$\  $$$$$$\   $$ |  $$ |  \$$$$$$  |
#           \__|  \__|  \________| \______|  \__|  \__|   \______/ 

# Built-ins
alias ls='\ls -pGrt --color=auto --group-directories-first' 
alias lsh='ls -d .*'
alias mkdir='mkdir -v' 
alias rv='rm -Iv' 
alias mv='mv -iv' 
alias cp='cp -iv' 
alias grep='grep --color=auto'

# Editing
alias e='$EDITOR'
alias sv='sudo -E $EDITOR'
alias eb='$EDITOR ~/.config/bash/config.bash'
alias eal='$EDITOR ~/.config/bash/alias.bash'
alias efu='$EDITOR ~/.config/bash/functions.bash'
alias vrc='$EDITOR ~/.vim/vimrc'
alias nvrc='$EDITOR ~/.config/nvim/init.vim'

# Package manager
alias sp='sudo pacman'

# Open files
alias j='nohup jupyter lab > /dev/null &'
alias feh='feh --scale-down --auto-zoom'
alias less='less -i'
alias p='less -i'

# Navigation
alias h='cd $HOME' 
alias sb='source ~/.bashrc'

# Conda environments
alias ds='conda activate data_science'
alias ac='conda activate'
alias da='conda deactivate'

# Network connections
alias q='qstat -u cr216'
alias cx1='ssh -t cx1 "~/usr/local/bin/bash -l"'
alias nhpc='ssh carles@nhpc16.ch.ic.ac.uk'
alias vpn='nmcli connection up --ask ic'

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
if command -v git >/dev/null 2>&1
then

    alias g='git'
    alias gr='git reset'
    alias grh='git reset --hard HEAD~'
    alias gs='git status'
    alias ga='git add'
    alias gb='git branch -avv'
    alias gc='git commit'
    alias gd='git diff'
    alias gca='git commit -a --amend --no-edit'
    alias gch='git checkout'
    alias gp='git pull'
    alias gl='git log -20 --oneline --graph --all'
    alias gls='git ls-tree --name-only HEAD'
    alias gitdf="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    alias gitdfls='gitdf ls-tree --name-only HEAD'

    # Source prompt and autocompletion files
    test -f ~/.config/git/git-prompt.sh && source $_
    if [ -f ~/.config/git/git-completion.bash ]
    then
        source ~/.config/git/git-completion.bash 
        __git_complete gitdf _git
        __git_complete g _git
        __git_complete gr _git_reset
        __git_complete gs _git_status
        __git_complete ga _git_add
        __git_complete gc _git_commit
        __git_complete gd _git_diff
        __git_complete gch _git_checkout
        __git_complete gp _git_pull
    fi
fi

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
