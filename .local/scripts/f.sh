#! /usr/bin/env bash

if [ -z "$@" ]
then
    find ~/phd/literature -printf '%P\n'
    # echo "ROFI_RETV = ${ROFI_RETV}"
else
    coproc ( zathura ~/phd/literature/"$@" & > /dev/null 2>&1 )
fi
