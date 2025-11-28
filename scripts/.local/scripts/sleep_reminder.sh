#!/bin/bash

# --- Sleep Reminder Script (GUI + Midnight Shutdown + Extend Feature) ---

QUESTION="Is that stuff really that important?"
TIMEOUT=60  # seconds before auto-shutdown
EXTEND_MINUTES=10

ask_question() {
  zenity --question \
    --title="💤 Sleep Reminder" \
    --text="$QUESTION" \
    --timeout=$TIMEOUT \
    --ok-label="Yes" \
    --extra-button="Extend 10 min" \
    --cancel-label="No" \
    2>/dev/null

  return $?   # return zenity exit code
}

while true; do
  HOUR=$(date +%H)

  # Midnight: force shutdown
  if [[ "$HOUR" == "00" ]]; then
    notify-send "💤 It's midnight!" "Time to sleep — shutting down..."
    systemctl poweroff
    exit 0
  fi

  # Only ask at 23:00 or after extensions
  if [[ "$HOUR" == "23" ]]; then
    ask_question
    RESULT=$?

    if [[ $RESULT -eq 0 ]]; then
      # User pressed "Yes"
      notify-send "😐 Okay then..." "Don't stay up too late."
      exit 0

    elif [[ $RESULT -eq 1 ]]; then
      # User pressed "No"
      notify-send "💤 Shutting down..." "Good night 😴"
      systemctl poweroff
      exit 0

    elif [[ $RESULT -eq 5 ]]; then
      # User pressed "Extend 10 min"
      notify-send "⏳ Extended" "I'll remind you again in $EXTEND_MINUTES minutes."
      sleep ${EXTEND_MINUTES}m
      continue
    else
      # Timeout means shutdown
      notify-send "💤 Shutting down..." "Good night 😴"
      systemctl poweroff
      exit 0
    fi
  fi

  sleep 30
done

