#! /bin/sh
#
# fuzzy_lock.sh
#
# Locks i3 by blurring the screen.

# lxdm -c USER_SWITCH

pgrep sway > /dev/null
IS_SWAY=$?

if [[ $IS_SWAY == 0 ]]; then
    pgrep swaylock && exit
else
    pgrep i3lock && exit
fi

STATIC_IMAGE=0
LOCK_IMAGE=0

SOURCE_IMAGE=/usr/share/wallpapers/Next/contents/images/3200x2000.png
IMAGE_FILE=$HOME/tmp/screen_locked.png

if [[ $# == 0 ]] || [[ $1 != "--no-scrot" ]]; then
    resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
    filters='noise=alls=10,scale=iw*.25:-1,gblur=sigma=5,scale=iw*4:-1:flags=neighbor'
    if [[ $STATIC_IMAGE == 1 ]]; then
        cp $SOURCE_IMAGE $IMAGE_FILE
    else
        ffmpeg -y -loglevel 0 -s "$resolution" -f x11grab -i $DISPLAY -vframes 1 \
            -vf "$filters" "$IMAGE_FILE"
    fi

    if [[ $LOCK_IMAGE == 1 ]]; then
        convert $IMAGE_FILE ~/bin/lock.png -gravity center -composite -matte $IMAGE_FILE
    fi
fi

# Lock Screen
if [[ $IS_SWAY == 0 ]]; then
    swaylock -ei "$IMAGE_FILE" -c 000000
else
    i3lock -ei "$IMAGE_FILE" -c 000000
fi

sleep 1 && $HOME/bin/set_wallpaper.sh $HOME/Pictures/wallpapers/
