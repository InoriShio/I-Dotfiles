#!/bin/zsh

APP="hyprsunset"

START=14
END=09

CURRENT=$(date +%H)

if { [[ $CURRENT -lt $START ]] && [[ $CURRENT -ge $END ]] }; then
	pkill -x "$APP"
	exit 0
else
  if { [[ $CURRENT -ge $START ]] || [[ $CURRENT -lt $END ]] }; then
	  XDG_RUNTIME_DIR="/run/user/1000" WAYLAND_DISPLAY="wayland-1" hyprsunset -t 2600 &
  fi
fi
