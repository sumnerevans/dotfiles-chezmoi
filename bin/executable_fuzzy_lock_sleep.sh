#! /usr/bin/env sh
#
# fuzzy_lock_sleep.sh
#
# Fuzzy lock with a sleep timer.

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

$HOME/bin/fuzzy_lock.sh $1 $2

prev_kbdlight=$(kbdlight get)

# Turn off the display after a time
off_sec=60
i=0

while [[ $(pgrep i3lock) ]]
do
    if (( $i > $off_sec )); then
        xset dpms force off
        # fade_kbdlight 0

        until [[ "$(xset -q | sed -ne 's/^[ ]*Monitor is //p')" == "On" ]]
        do
            sleep 0.75
        done

        # fade_kbdlight "$prev_kbdlight"

        i=0
    fi

    i=$(($i + 1))
    sleep 1
done
