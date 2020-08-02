#! /bin/sh
# Enables systemd user services.

SERVICES=(
    clipmenud
    kde-connect-indicator
    mailnotify
    nextcloud
    offlinemsmtp
    picom
    wallpaper
    writeping
)
TIMERS=(
    mailfetch
    wallpaper
)

echo "Enabling services..."
for s in ${SERVICES[@]}; do
    systemctl --user enable --now $s.service
done

echo "Enabling timers..."
for t in ${TIMERS[@]}; do
    systemctl --user enable --now $t.timer
done
