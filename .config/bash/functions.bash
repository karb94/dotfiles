
#        ____  __  __   _  __  _____ ______   ____  ____    _  __   ____
#       / __/ / / / /  / |/ / / ___//_  __/  /  _/ / __ \  / |/ /  / __/
#      / _/  / /_/ /  /    / / /__   / /    _/ /  / /_/ / /    /  _\ \  
#     /_/    \____/  /_/|_/  \___/  /_/    /___/  \____/ /_/|_/  /___/ 


s () {
  setsid -f "$@"; exit
}

o () {
  setsid xdg-open "$@" && sleep 2 && exit
}

# lfcd () {
#     tmp="$(mktemp)"
#     lf -last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp"
#         if [ -d "$dir" ]; then
#             if [ "$dir" != "$(pwd)" ]; then
#                 cd "$dir"
#             fi
#         fi
#     fi
# }
lfcd () {
  # `command` is needed in case `lfcd` is aliased to `lf`
  cd "$(command lf -print-last-dir "$@")"
}
bind '"\C-f":" lfcd\C-m"'
# bind -m emacs-standard '"\C-f": " \C-b\C-k \C-u`lfcd`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'

push () {
    # If number of arguments is one
    if [ $# -eq 1 ]
    then
        git commit -am "$1"
    else
        git commit -am 'Fast push'
    fi
    git push
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
    local path
    path=$(pwd)

    while  [ ! -f "${path}/$1" ]
    do
        [ "$path" == "$HOME" ] && echo "reached home"
        [ "$path" == "/" ] && echo "reached /"
        # Exit when reaching home or root directory
        { [ "$path" == "$HOME" ] || [ "$path" == "/" ] ;} &&
            echo "$1 not found" 2>&1 && return 1
        path=${path%/*}
    done
    echo "$path"
}
