

#    $$$$$$\    $$\   $$\
#   $$  __$$\   $$ |  \__|
#   $$ /  $$ |  $$ |  $$\   $$$$$$\    $$$$$$$\
#   $$$$$$$$ |  $$ |  $$ |  \____$$\  $$  _____|
#   $$  __$$ |  $$ |  $$ |  $$$$$$$ | \$$$$$$\
#   $$ |  $$ |  $$ |  $$ | $$  __$$ |  \____$$\
#   $$ |  $$ |  $$ |  $$ | \$$$$$$$ | $$$$$$$  |
#   \__|  \__|  \__|  \__|  \_______| \_______/


alias_sourced=$(stat -c %Y ~/.config/shell/alias.bash)

# CX1
if [[ $HOSTNAME =~ login-[0-9]+ ]]
then
    alias v='~/usr/local/bin/vim -Nu $HOME/.vim/mvrc'
    alias a='availability'
    alias eph="cd $EPHEMERAL"
    alias q='qstat -a'
    alias cy='grep "MAX G" -A3'
    alias coor='grep "ALPHA" -A1'
    alias en='grep "TOTAL EN"'
    alias conv='grep "OPT END"'
    alias etot='grep ETOT'
    alias spin='grep SUMMED'
    alias vsub='vi ~/bin/sub'
    alias lsout='ls *.out'
else
    alias j='nohup jupyter lab > /dev/null &'
    alias cx1='ssh -t cx1 "~/usr/local/bin/bash -l"'
    alias nhpc='ssh carles@nhpc16.ch.ic.ac.uk'
fi

# White City Desktop
if [ $(uname) == "Linux" ]
then
    if [[ $(sed -n '/^NAME=/s/.*"\(.*\)"/\1/p' /etc/os-release) = "Arch Linux" ]]
    then
        alias feh='feh --scale-down --auto-zoom'
        alias p='pacman'
        alias sp='sudo pacman'
        alias v='/usr/bin/vim'
    fi
fi

# MacAir
if [ $(uname) == "Darwin" ]
then
    alias v='/usr/local/bin/vim'
    alias run='runcry14'
    alias runprop='runprop14'
fi

# Aliases
alias mkdir='mkdir -v' 
alias mv='mv -iv' 
alias cp='cp -iv' 
alias h='cd $HOME' 
alias ls='\ls -pG --color=auto --group-directories-first' 
alias lsh='ls -d .*'
alias sv='sudo v'
alias sb='source ~/.bashrc'
alias vb='vim ~/.config/shell/config.bash'
alias val='vim ~/.config/shell/alias.bash'
alias vrc='vim ~/.vim/vimrc'
alias r='ranger'
alias grep='grep --color=auto'
alias ds='conda activate data_science'
alias ac='conda activate'
alias da='conda deactivate'

# For git
if command -v git >/dev/null 2>&1
then
    alias gitdf="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    __git_complete gitdf _git
    alias g='git'
    __git_complete g _git
    alias gr='git reset --hard'
    __git_complete gr _git_reset
    alias gs='git status'
    __git_complete gs _git_status
    alias ga='git add'
    __git_complete ga _git_add
    alias gb='git branch -avv'
    alias gc='git commit'
    __git_complete gc _git_commit
    alias gch='git checkout'
    __git_complete gch _git_checkout
    alias gp='git pull'
    __git_complete gp _git_pull
    alias gl='git log --oneline --graph --all'
    alias gs='git ls-tree --full-tree --name-only -r HEAD'
    alias gitdfls='gitdf ls-tree --full-tree --name-only -r HEAD'
fi

# Functions
push () {
    if [ $# -eq 1 ]
    then
        git commit -am "$1"
    else
        git commit -am 'Fast push'
    fi
    git push
}

pull () {
    git reset --hard
    git pull
}

pushdf () {
    gitdf add -u
    if [ $# -eq 1 ]
    then
        echo $1
        gitdf commit -m "$1"
    else
        gitdf commit -m 'Updated dotfiles'
    fi
    gitdf push
}

pulldf () {
    gitdf reset --hard
    gitdf pull
}

shopt -s extglob
extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c=(bsdtar xvf);;
            *.7z)  c=(7z x);;
            *.Z)   c=(uncompress);;
            *.bz2) c=(bunzip2);;
            *.exe) c=(cabextract);;
            *.gz)  c=(gunzip);;
            *.rar) c=(unrar x);;
            *.xz)  c=(unxz);;
            *.zip) c=(unzip);;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command "${c[@]}" "$i"
        ((e = e || $?))
    done
    return "$e"
}

# fff
f() {
    fff "$@"
        cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}
