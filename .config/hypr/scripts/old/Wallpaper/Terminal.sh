#!/bin/zsh

export XDG_RUNTIME_DIR="/run/user/1000"

output_file="/tmp/random_images.list"
scheme_dir="/home/inorishio/.cache/wal/schemes/"
background_dir="/home/inorishio/Pictures/Backgrounds/"
random_images=("${(@f)$(< "$output_file")}")

populate_random_schemes() {
    substract0=("${random_images[@]/$background_dir/$scheme_dir}")
    substract1=("${substract0[@]/.png/}")
    random_schemes=("${substract1[@]/.jpg/}")
}

populate_random_schemes

wal_ran_for_ws=0

handle_terminal_workspace() {
    if [[ "$1" =~ workspace* ]]; then
        local ws="${1##*>>}"
        if [[ "$ws" == "1" && "$wal_ran_for_ws" -eq 0 ]]; then
            wal -f "${random_schemes[1]}"
            wal_ran_for_ws=1
        fi
    fi
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
    while read -r line; do
        handle_terminal_workspace "$line"
done
