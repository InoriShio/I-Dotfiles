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

        if (( ws <= ${#random_schemes[@]} )); then
            wal -f "${random_schemes[$ws]}"
            echo "Applied ${random_schemes[$ws]} for workspace $ws"
        else
            echo "No theme assigned for workspace $ws"
        fi
    fi
}

# 📦 Poll terminal workspace assignment in background
track_terminal_workspace() {
    local last_ws=""
    while true; do
        terminal_ws=$(hyprctl clients -j | jq -r '.[] | select(.class == "foot") | .workspace.id' | head -n1)

        if [[ "$terminal_ws" != "$last_ws" && "$terminal_ws" != "null" ]]; then
            if (( terminal_ws <= ${#random_schemes[@]} )); then
                wal -f "${random_schemes[$terminal_ws]}"
                echo "Applied ${random_schemes[$terminal_ws]} for foot terminal on workspace $terminal_ws"
            fi
            last_ws="$terminal_ws"
        fi

        sleep 0.5
    done
}

# Start the terminal workspace watcher in background
track_terminal_workspace &

# Listen for Hyprland events in foreground
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
    while read -r line; do
        handle_workspace_event "$line"
    done
