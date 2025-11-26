#!/bin/bash

# --- Sleep Reminder Script (GUI + Midnight Shutdown) ---
QUESTION="Is that stuff really that important?"
TIMEOUT=60  # seconds before auto-shutdown

HOUR=$(date +%H)

# If time is midnight (00), shutdown immediately
if [[ "$HOUR" == "00" ]]; then
  notify-send "💤 It's midnight!" "Time to sleep — shutting down..."
  systemctl poweroff
  exit 0
fi

# Ask at 11 PM
if [[ "$HOUR" == "23" ]]; then
  # Ask using zenity popup
  zenity --question \
    --title="💤 Sleep Reminder" \
    --text="$QUESTION" \
    --timeout=$TIMEOUT \
    --ok-label="Yes" \
    --cancel-label="No" \
    2>/dev/null

  # $? == 0 if "Yes", else shutdown
  if [[ $? -eq 0 ]]; then
    notify-send "😐 Okay then..." "Don't stay up too late."
    exit 0
  else
    notify-send "💤 Shutting down..." "Good night 😴"
    systemctl poweroff
  fi
fi

