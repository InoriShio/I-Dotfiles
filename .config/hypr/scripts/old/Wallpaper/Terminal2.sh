#!/bin/zsh

export XDG_RUNTIME_DIR="/run/user/1000"

output_file="/tmp/random_images.list"
scheme_dir="/home/inorishio/.cache/wal/schemes/"
background_dir="/home/inorishio/Pictures/Backgrounds/"

# Load list of random images
random_images=("${(@f)$(< "$output_file")}")

populate_random_schemes() {
    local tmp=()
    for img in "${random_images[@]}"; do
        img_name="${img##*/}"         # get filename
        img_name="${img_name%.*}"     # remove extension
        tmp+=("$scheme_dir/$img_name.json")
    done
    random_schemes=("${tmp[@]}")
}

populate_random_schemes

current_workspace=""

handle_workspace_event() {
    if [[ "$1" == *"workspace>>"* ]]; then
        ws="${1##*>>}"
        current_workspace="$ws"

        # Map workspace number to array index (Zsh arrays start at 1)
        if (( ws <= ${#random_schemes[@]} )); then
            wal -f "${random_schemes[$ws]}"
            echo "Applied ${random_schemes[$ws]} for workspace $ws"
        else
            echo "No theme assigned for workspace $ws"
        fi
    fi
}

# Listen for events from Hyprland
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
    while read -r line; do
        handle_workspace_event "$line"
    done
