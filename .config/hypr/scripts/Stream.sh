#!/bin/zsh

XDG_RUNTIME_DIR="/run/user/1000"

handle() {
    case $1 in
        "screencast>>1,"*)
            swaync-client --inhibitor-add "xdg-desktop-portal-hyprland" &
        ;;
        "screencast>>0,"*)
            echo hi &
            swaync-client --inhibitor-remove "xdg-desktop-portal-hyprland" &
        ;;
    esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
