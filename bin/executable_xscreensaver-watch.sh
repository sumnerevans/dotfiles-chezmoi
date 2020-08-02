#! /usr/bin/env sh

function fade_kbdlight() {
    current=$(kbdlight get)
    [[ "$1" == "$current" ]] && return
    (( $1 > $current )) && dx=1 || dx=-1

    while [[ "$1" != "$current" ]]
    do
        current=$(($current + $dx))
        kbdlight set "$current"
        sleep 0.01
    done
}

process() {
    while read input; do
        case "$input" in
            UNBLANK*)
                fade_kbdlight "$prev_kbdlight"
                /home/sumner/bin/set_wallpaper.sh
                ;;
            LOCK*)
                prev_kbdlight=$(kbdlight get)
                fade_kbdlight 0 ;;
        esac
    done
}

/usr/bin/xscreensaver-command -watch | process
