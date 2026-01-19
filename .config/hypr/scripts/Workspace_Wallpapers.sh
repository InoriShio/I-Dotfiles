#!/bin/zsh

export XDG_RUNTIME_DIR="/run/user/1000"

num_workspaces=10

random_images=()

background_dir="/home/inorishio/Pictures/Backgrounds/"

populate_random_images() {
    local images=($(find $background_dir -type f | shuf -n $num_workspaces))
    random_images=("${images[@]}")
}

wal_ran_for_ws=(0 0 0 0 0 0 0 0 0 0)

set_wal_for_workspace() {
    for i in {1..10}; do
            wal_ran_for_ws[$i]=0
    done
}

handle_background() {
    case $1 in
        "workspace>>1") swww img --transition-type none "${random_images[1]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 1 ]]; then
            if [[ "${wal_ran_for_ws[1]}" -eq 0 ]]; then
                wal -i "${random_images[1]}" -I cursor
                set_wal_for_workspace 1
            fi
            wal_ran_for_ws[1]=1
        fi ;;
        "workspace>>2") swww img --transition-type none "${random_images[2]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 2 ]]; then
            if [[ "${wal_ran_for_ws[2]}" -eq 0 ]]; then
                wal -i "${random_images[2]}" -I cursor
                set_wal_for_workspace 2
            fi
            wal_ran_for_ws[2]=1
        fi ;;
        "workspace>>3") swww img --transition-type none "${random_images[3]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 3 ]]; then
            if [[ "${wal_ran_for_ws[3]}" -eq 0 ]]; then
                wal -i "${random_images[3]}" -I cursor
                set_wal_for_workspace 3
            fi
            wal_ran_for_ws[3]=1
        fi ;;
        "workspace>>4") swww img --transition-type none "${random_images[4]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 4 ]]; then
            if [[ "${wal_ran_for_ws[4]}" -eq 0 ]]; then
                wal -i "${random_images[4]}" -I cursor
                set_wal_for_workspace 4
            fi
            wal_ran_for_ws[4]=1
        fi ;;
        "workspace>>5") swww img --transition-type none "${random_images[5]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 5 ]]; then
            if [[ "${wal_ran_for_ws[5]}" -eq 0 ]]; then
                wal -i "${random_images[5]}" -I cursor
                set_wal_for_workspace 5
            fi
            wal_ran_for_ws[5]=1
        fi ;;
        "workspace>>6") swww img --transition-type none "${random_images[6]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 6 ]]; then
            if [[ "${wal_ran_for_ws[6]}" -eq 0 ]]; then
                wal -i "${random_images[6]}" -I cursor
                set_wal_for_workspace 6
            fi
            wal_ran_for_ws[6]=1
        fi ;;
        "workspace>>7") swww img --transition-type none "${random_images[7]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 7 ]]; then
            if [[ "${wal_ran_for_ws[7]}" -eq 0 ]]; then
                wal -i "${random_images[7]}" -I cursor
                set_wal_for_workspace 7
            fi
            wal_ran_for_ws[7]=1
        fi ;;
        "workspace>>8") swww img --transition-type none "${random_images[8]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 8 ]]; then
            if [[ "${wal_ran_for_ws[8]}" -eq 0 ]]; then
                wal -i "${random_images[8]}" -I cursor
                set_wal_for_workspace 8
            fi
            wal_ran_for_ws[8]=1
        fi ;;
        "workspace>>9") swww img --transition-type none "${random_images[9]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 9 ]]; then
            if [[ "${wal_ran_for_ws[9]}" -eq 0 ]]; then
                wal -i "${random_images[9]}" -I cursor
                set_wal_for_workspace 9
            fi
            wal_ran_for_ws[9]=1
        fi ;;
        "workspace>>10") swww img --transition-type none "${random_images[10]}"
        if [[ "$(hyprctl activewindow | grep 'initialClass:' | awk '{print $2}')" == "footclient" && "$(hyprctl activewindow | grep 'workspace:' | awk '{print $2}')" -eq 10 ]]; then
            if [[ "${wal_ran_for_ws[10]}" -eq 0 ]]; then
                wal -i "${random_images[10]}" -I cursor
                set_wal_for_workspace 10
            fi
            wal_ran_for_ws[10]=1
        fi ;;
    esac
}

populate_random_images

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
    while read -r line; do
        handle_background "$line"
done
