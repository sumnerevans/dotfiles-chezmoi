#! /usr/bin/env sh

if [[ $(setxkbmap -query | command grep 'variant:') =~ "3l" ]]; then
    echo "Setting to US"
    setxkbmap us
else
    echo "Setting to 3l"
    setxkbmap us 3l
fi
