#!/bin/bash

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="main"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

# Set the source audio player here.
# Players supporting the MPRIS spec are supported.
# Examples: spotify, vlc, chrome, mpv and others.
# Use `playerctld` to always detect the latest player.
# See more here: https://github.com/altdesktop/playerctl/#selecting-players-to-control
INSTANCE1="spotify"
INSTANCE2="spotify_player"

# Format of the information displayed
# Eg. {{ artist }} - {{ album }} - {{ title }}
# See more attributes here: https://github.com/altdesktop/playerctl/#printing-properties-and-metadata
FORMAT="{{ title }} - {{ artist }}"
PLAYER="$INSTANCE1"
PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)

# Sends $2 as message to all polybar PIDs that are part of $1
update_hooks() {
    while IFS= read -r id
    do
      polybar-msg -p "$id" action spotify-play-pause hook $2 1>/dev/null 2>&1
    done < <(echo "$1")
}

if [ -z $PLAYERCTL_STATUS ]; then
    PLAYER="$INSTANCE2"
    PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)
fi

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
else
    STATUS="Offline"
fi

if [ "$1" == "--status" ]; then
    echo "$STATUS"
else
    if [ "$STATUS" = "Stopped" ]; then
        echo "No music is playing"
    elif [ "$STATUS" = "Paused"  ]; then
        update_hooks "$PARENT_BAR_PID" 0
        playerctl --player=$PLAYER metadata --format "$FORMAT"
    elif [ "$STATUS" = "Offline"  ]; then
        echo "$STATUS"
    else
        update_hooks "$PARENT_BAR_PID" 1
        playerctl --player=$PLAYER metadata --format "$FORMAT";
    fi
fi

