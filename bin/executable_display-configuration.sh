#! /usr/bin/env sh
# Figures out how to XRandr properly for whatever the current display
# configuration is.

set -x

# ROTATION="left"
ROTATION="normal"

DP0=$(xrandr | grep '^DP-0 connected')
DP1=$(xrandr | grep '^DP1 connected')
DP2=$(xrandr | grep '^DP2 connected')
DP4=$(xrandr | grep '^DP4 connected')
DP23=$(xrandr | grep '^DP2-3 connected')
DP13=$(xrandr | grep '^DP1-3 connected')
DP3=$(xrandr | grep '^DP-3 connected')
HDMI2=$(xrandr | grep '^HDMI2 connected')

# Desktop
DP4=$(xrandr | grep 'DP-4 connected')

if [[ $DP1 != "" ]]; then
    # External monitor at home
    xrandr --output DP1 --mode 1920x1200 --right-of eDP1 --rotate $ROTATION
elif [[ $DP2 != "" ]]; then
    # External monitor at home (other USB-C port)
    xrandr --output DP2 --mode 1920x1200 --right-of eDP1 --rotate $ROTATION
elif [[ $DP4 != "" ]]; then
    if [[ $DP4 != "" ]]; then
        # Double monitor set up with Desktop
        xrandr --output DP-0 --mode 2560x1440 --rate 144.00 --primary
        xrandr --output DP-4 --mode 2560x1440 --right-of DP-0 --rotate $ROTATION
    else
        xrandr --output DP-0 --mode 2560x1440 --rotate $ROTATION --primary
    fi
elif [[ $DP23 != "" ]]; then
    # External monitor at home (USB-C dock)
    xrandr --output DP2-3 --mode 1920x1200 --right-of eDP1 --rotate $ROTATION
elif [[ $DP13 != "" ]]; then
    # External monitor at home (USB-C dock)
    xrandr --output DP1-3 --mode 1920x1200 --right-of eDP1 --rotate $ROTATION
elif [[ $DP3 != "" ]]; then
    # External monitor at home, from MacBook Pro (make sure to scale).
    xrandr --output DP-3 --mode 1920x1200 --right-of DP-2 --scale 1.5x1.5 --rotate $ROTATION
elif [[ $HDMI2 != "" ]]; then
    # External monitor at home, from MacBook Pro (make sure to scale).
    xrandr --output HDMI2 --mode 1920x1200 --right-of eDP1
else
    xrandr --output DP1 --off
    xrandr --output DP2 --off
    xrandr --output DP3 --off
    xrandr --output DP-3 --off
    xrandr --output DP1-1 --off
    xrandr --output DP1-2 --off
    xrandr --output DP1-3 --off
    xrandr --output DP2-1 --off
    xrandr --output DP2-2 --off
    xrandr --output DP2-3 --off
    xrandr --output HDMI1 --off
    xrandr --output HDMI2 --off
    xrandr --auto
fi
