#!/bin/bash

TIME_LIMIT=1200        # 20 minutes in seconds
WARNING_TIME=$((TIME_LIMIT - 120)) # 2 minutes before time limit
CHECK_INTERVAL=5

SOUND="/System/Library/Sounds/Submarine.aiff"

minecraft_pid=""
start_time=""
warned=false

notify() {
  /usr/bin/osascript -e "display notification \"$1\" with title \"Minecraft Timer\""
}

play_sound() {
  /usr/bin/afplay "$SOUND"
}

while true; do
  pid=$(pgrep -f "Minecraft")

  if [[ -n "$pid" ]]; then
    if [[ -z "$minecraft_pid" ]]; then
      minecraft_pid="$pid"
      start_time=$(date +%s)
      warned=false
      echo "Minecraft started (PID $minecraft_pid)"
    fi

    now=$(date +%s)
    elapsed=$((now - start_time))

    if [[ "$elapsed" -ge "$WARNING_TIME" && "$warned" = false ]]; then
      notify "⚠️ 2 minuter kvar, spara spelet!"
      play_sound
      warned=true
    fi

    if [[ "$elapsed" -ge "$TIME_LIMIT" ]]; then
      notify "⛔ Tiden är ute! Stänger Minecraft."
      play_sound
      kill "$minecraft_pid"
      minecraft_pid=""
      start_time=""
      warned=false
    fi
  else
    minecraft_pid=""
    start_time=""
    warned=false
  fi

  sleep "$CHECK_INTERVAL"
done
