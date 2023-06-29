#!/bin/bash
BAR_CONFIG=~/.config/polybar/config.ini 

PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


# Launch on primary monitor
TRAY=right MONITOR=$PRIMARY polybar --reload -c $BAR_CONFIG main &
# Launch on all other monitors
for m in $OTHERS; do
  TRAY=none MONITOR=$m polybar --reload -c $BAR_CONFIG second &
done

echo "Polybar launched..."
