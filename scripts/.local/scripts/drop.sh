#!/bin/bash

# Eye Drops Reminder Script for Hyprland (Arch Linux)
# Requires: libnotify + mako or swaync notification daemon

# Times (24-hour format)
times=("08:00" "12:00" "16:00" "20:47")

while true; do
  now=$(date +%H:%M)
  
  for t in "${times[@]}"; do
    if [[ "$now" == "$t" ]]; then
      notify-send "💧 Eye Drops Reminder" "Time to use your eye drops 👀"
      echo "$(date): Sent reminder for $t"
      sleep 60  # avoid multiple notifications in the same minute
    fi
  done

  sleep 30  # check every 30 seconds
done

