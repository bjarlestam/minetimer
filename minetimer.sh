#!/bin/bash
echo "Starting minecraft timer..."

TIME_LIMIT=60        # 20 minutes in seconds
WARNING_TIME=$((TIME_LIMIT - 30)) # 2 minutes before time limit
CHECK_INTERVAL=5

SOUND="/System/Library/Sounds/Submarine.aiff"

minecraft_pid=""
start_time=""
warned=false

notify() {
  /usr/bin/osascript -e "display alert \"Minecraft Timer\" message \"$1\"" &
}

play_sound() {
  /usr/bin/afplay "$SOUND"
}

while true; do
  TARGET_USER="USER_NAME_GOES_HERE"
  # Match "minecraft" case-insensitively to catch "Minecraft.app" (launcher) and "java ... minecraft" (game)
  current_pids=$(pgrep -u "$TARGET_USER" -f -i "minecraft")

  if [[ -n "$current_pids" ]]; then
    if [[ -z "$start_time" ]]; then
      start_time=$(date +%s)
      warned=false
      echo "Minecraft started"
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
      # Kill all detected minecraft processes
      echo "$current_pids" | xargs kill
      start_time=""
      warned=false
    fi
  else
    start_time=""
    warned=false
  fi

  sleep "$CHECK_INTERVAL"
done
