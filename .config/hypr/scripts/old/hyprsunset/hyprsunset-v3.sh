#!/bin/sh

START=20
END=11
CURRENT=$(date +%H)
HYPRPRO=$(pgrep -x hyprsunset)

if { [[ $CURRENT -lt $START ]] || [[ $CURRENT -ge $END ]] }; then
    pkill hyprsunset
else
    if { [[ $CURRENT -ge $START ]] || [[ $CURRENT -lt $END ]] }; then
        systemctl --user start newhyprsunset.service
    fi
fi
