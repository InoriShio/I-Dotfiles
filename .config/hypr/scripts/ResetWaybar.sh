#!/bin/zsh

if pgrep waybar; then
    pkill waybar && sass ~/.config/waybar/zbar/zbar.scss ~/.config/waybar/zbar/zbar.css && waybar -c ~/.config/waybar/zbar/config.jsonc -s ~/.config/waybar/zbar/zbar.css # Reload waybar
else
    sass ~/.config/waybar/zbar/zbar.scss ~/.config/waybar/zbar/zbar.css && waybar -c ~/.config/waybar/zbar/config.jsonc -s ~/.config/waybar/zbar/zbar.css # Reload waybar
fi

