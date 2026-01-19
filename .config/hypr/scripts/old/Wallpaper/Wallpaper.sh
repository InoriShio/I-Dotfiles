#!/bin/zsh

export XDG_RUNTIME_DIR="/run/user/1000"

output_file="/tmp/random_images.list"
random_images=("${(@f)$(< "$output_file")}")

handle_background() {
    case $1 in
        "workspace>>1") swww img --transition-type none "${random_images[1]}" ;;
        "workspace>>2") swww img --transition-type none "${random_images[2]}" ;;
        "workspace>>3") swww img --transition-type none "${random_images[3]}" ;;
        "workspace>>4") swww img --transition-type none "${random_images[4]}" ;;
        "workspace>>5") swww img --transition-type none "${random_images[5]}" ;;
        "workspace>>6") swww img --transition-type none "${random_images[6]}" ;;
        "workspace>>7") swww img --transition-type none "${random_images[7]}" ;;
        "workspace>>8") swww img --transition-type none "${random_images[8]}" ;;
        "workspace>>9") swww img --transition-type none "${random_images[9]}" ;;
        "workspace>>10") swww img --transition-type none "${random_images[10]}" ;;
    esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
    while read -r line; do
        handle_background "$line"
done
