#!/bin/sh

START=21
END=10
CURRENT=$(date +%H)

if { [[ $CURRENT -lt $START ]] && [[ $CURRENT -ge $END ]] }; then
      systemctl --user start stophyprsunset.service
else
    if { [[ $CURRENT -ge $START ]] || [[ $CURRENT -lt $END ]] }; then
        systemctl --user start starthyprsunset.service
    fi
fi
