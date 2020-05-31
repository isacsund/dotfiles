#!/usr/bin/env bash

# Terminate laready running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch top bar
polybar -c ~/.config/polybar/config.ini main &
