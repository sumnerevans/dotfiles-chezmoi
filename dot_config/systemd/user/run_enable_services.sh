#! /bin/sh
# Enables systemd user services.

SERVICES=(
    clipmenud
    kde-connect-indicator
    nextcloud
    offlinemsmtp
    picom
    redshift-gtk
    wallpaper
    writeping
)
TIMERS=(
    mailfetch
    wallpaper
)

for s in $SERVICES; do
    systemctl --user enable --now $s.service
done

for t in $TIMERS; do
    systemctl --user enable --now $t.timer
done
