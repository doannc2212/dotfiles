#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
# polybar main --config=~/.config/polybar/config.ini &
# xrandr --query | grep " connected" | cut -d" " -f1 | wc -l
# if there's only one monitor, launch polybar main
# else if there are more than two monitors, launch polybar main and second
polybar main --config=~/.config/polybar/config.ini &
if [ $(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l) -gt 1 ]; then
  polybar second --config=~/.config/polybar/config.ini &
fi

echo "Polybar launched..."
