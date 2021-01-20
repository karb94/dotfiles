
#        ____  __  __   _  __  _____ ______   ____  ____    _  __   ____
#       / __/ / / / /  / |/ / / ___//_  __/  /  _/ / __ \  / |/ /  / __/
#      / _/  / /_/ /  /    / / /__   / /    _/ /  / /_/ / /    /  _\ \  
#     /_/    \____/  /_/|_/  \___/  /_/    /___/  \____/ /_/|_/  /___/ 



# t () {
#     pgrep -vx tmux > /dev/null
# }
t () {
    pgrep -x "tmux: server" > /dev/null && tmux attach-session ||
    ( tmux new-session -d -s delete-me &&
    tmux run-shell "${TMUX_DIR}/plugins/tmux-resurrect/scripts/restore.sh"
    tmux kill-session -t delete-me && tmux attach-session )
}

s () {
    setsid -f "$@"; exit
}

misc () {
    cmd="$(cat $HOME/.local/scripts/miscellaneous | fzf)"
    cmd=${cmd%#*}
    history -s "$cmd"
    $cmd
}

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
bind '"\C-f":"\033cc clear; lfcd\C-m"'

vs () {
    echo
    if [ -f "Session.vim" ]
    then
        $EDITOR -S
    else
        echo No "Session.vim" file
    fi
}

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
    if [ $# -eq 1 ]
    then
        echo $1
        git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -am "$1"
    else
        git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME \
            commit -am 'Updated dotfiles'
    fi
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push
}

pulldf () {
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull
}

extract () {
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

findup() {
    [ -z "$1" ] && echo "No argument was passed" 2>&1 && return 1
    local path=$(pwd)

    while  [ ! -f "${path}/$1" ]
    do
        [ "$path" == "$HOME" ] && echo "reached home"
        [ "$path" == "/" ] && echo "reached /"
        # Exit when reaching home or root directory
        ( [ "$path" == "$HOME" ] || [ "$path" == "/" ] ) &&
            echo "$1 not found" 2>&1 && return 1
        path=${path%/*}
    done
    echo "$path"
}

rpull() {
    # Store directory passed as argument, if none reverse search for remote
    if [ -z "$1" ]
    then
        local dir="$(findup remote)" ||
            ( echo "File \"remote\" not found" && return 1 )
                        else
                            # Strip last slash if there is one
                            local dir="${1%/}"
    fi

    # The remote directory
    local remote_path="${dir}"/remote
    if [ -f "$remote_path" ]
    then
        local remote="$(cat ${remote_path})"
        remote="${remote%/}"/

        # -a -> A mix of must have flags
        # -z -> Compress during transfer if possible
        # -P -> Do partial transfers and show progress
        # -h -> Human readable format
        # -v -> Verbose
        rsync -azPhv --delete --exclude=/remote  "${remote}" "${dir}"/
    else
        echo "There is no file named \"remote\" at ${dir}/"
    fi
}

rpush() {
    # Store directory passed as argument, if none reverse search for remote
    if [ -z "$1" ]
    then
        local dir="$(findup remote)" ||
            ( echo "File \"remote\" not found" && return 1 )
                else
                    # Strip last slash if there is one
                    local dir="${1%/}"
    fi

    # The remote directory
    local remote_path="${dir}"/remote
    if [ -f "$remote_path" ]
    then
        local remote="$(cat ${remote_path})"
        remote="${remote%/}"/

        # -a -> A mix of must have flags
        # -z -> Compress during transfer if possible
        # -u -> Update files only if outdated or have different size
        # -h -> Human readable format
        # -v -> Verbose
        # rsync -azuhvn --exclude=/remote  "${dir}"/ "${remote%/}"
        printf "\nThese files will be uploaded:\n\n"
        rsync -azuhvn --exclude=/remote  "${dir}"/ "${remote%/}" 2> /dev/null |
            awk ' /sending/ {f=1;next}
                f { if ($0 == "") {exit} {printf "\t%s\n", $0} }' &&
                    printf "\n\n"
            
        read  -n 1 -r -s -p 'Press "y" to proceed'
        echo    # (optional) move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            rsync -azuh --progress --exclude=/remote  "${dir}"/ "${remote%/}" \
                2> /dev/null
        else
            printf "\nAborting...\n"
        fi
        # read -n 1 -s -r -p "Press any key to proceed"
    else
        echo "There is no file named \"remote\" at ${dir}/"
    fi
}
