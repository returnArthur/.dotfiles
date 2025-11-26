#!/bin/bash

HOSTS="/etc/hosts"
BLOCKS=(
"0.0.0.0 instagram.com"
"0.0.0.0 www.instagram.com"
"0.0.0.0 monkeytype.com"
"0.0.0.0 www.monkeytype.com"
)

if [ "$1" == "block" ]; then
    for line in "${BLOCKS[@]}"; do
        grep -qxF "$line" "$HOSTS" || echo "$line" | sudo tee -a "$HOSTS" > /dev/null
    done
elif [ "$1" == "unblock" ]; then
    for line in "${BLOCKS[@]}"; do
        sudo sed -i "\|$line|d" "$HOSTS"
    done
fi

