#!/usr/bin/env bash

typeset -i current_ws
current_ws=$(i3-msg -t get_workspaces \
    | jq '.[] | select(.focused==true).name' \
    | cut -d"\"" -f2)

i3-msg -q "rename workspace $current_ws to tmp"

if [ "$current_ws" -lt "$1" ]
then
    typeset -i i
    for ((i=$current_ws;i<$1;++i))
    do
        i3-msg -q "rename workspace $(($i+1)) to $i"
    done
    i3-msg -q "rename workspace tmp to $1"
elif [ "$current_ws" -gt "$1" ]
then
    typeset -i i
    for ((i=$current_ws;i>$1;--i))
    do
        i3-msg -q "rename workspace $(($i-1)) to $i"
    done
    i3-msg -q "rename workspace tmp to $1"
fi
