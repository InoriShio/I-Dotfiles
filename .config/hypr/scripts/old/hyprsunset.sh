#!/bin/zsh

hour=$(date +%H)

if [ $hour -ge 09 ] && [ $hour -lt 21 ]; then
    pkill hyprsunset
elif [ $hour -ge 21 ] || [ $hour -lt 09 ]; then
    WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000 hyprsunset -t 3200 &
fi
