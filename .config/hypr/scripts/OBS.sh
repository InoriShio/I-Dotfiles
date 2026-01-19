#!/bin/zsh

# Var
OBS='ws://localhost:4455'
PASSWORD="B9AybRWAAmxjUKdy"
last_recording_state=""
last_streaming_state=""

# Connect w/Websocket
coproc websocat -t "$OBS"

# Set Hello var
read -r hello <&p

# Extract from Hello msg
SALT=$(echo "$hello" | grep -o '"salt":"[^"]*"' | cut -d'"' -f4)
CHALLENGE=$(echo "$hello" | grep -o '"challenge":"[^"]*"' | cut -d'"' -f4)

# Secret
secret=$(printf "%s" "$PASSWORD$SALT" | openssl dgst -sha256 -binary | base64)
auth=$(printf "%s" "$secret$CHALLENGE" | openssl dgst -sha256 -binary | base64)

# Websocket Auth
print -p '{"op":1,"d":{"rpcVersion":1,"authentication":"'"$auth"'","eventSubscriptions":1023}}'

# Events
while IFS= read -r msg; do
    eventType=$(echo "$msg" | grep -o '"eventType":"[^"]*"' | cut -d':' -f2 | tr -d '"')
    outputActive=$(echo "$msg" | grep -o '"outputActive":[^,}]*' | cut -d':' -f2)

    case "$eventType" in
        RecordStateChanged)
            if [[ "$outputActive" != "$last_recording_state" ]]; then
                if [[ "$outputActive" == "true" ]]; then
                    swaync-client --inhibitor-add "xdg-desktop-portal-hyprland"
                else
                    swaync-client --inhibitor-remove "xdg-desktop-portal-hyprland"
                fi
                last_recording_state="$outputActive"
            fi;;
        StreamStateChanged)
            if [[ "$outputActive" != "$last_streaming_state" ]]; then
                if [[ "$outputActive" == "true" ]]; then
                    swaync-client --inhibitor-add "xdg-desktop-portal-hyprland"
                else
                    swaync-client --inhibitor-remove "xdg-desktop-portal-hyprland"
                fi
                last_streaming_state="$outputActive"
            fi;;
    esac
done <&p
