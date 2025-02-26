#!/usr/bin/env sh

# Check if a delta is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <delta>"
    exit 1
fi

# Validate that the provided delta is a number
if ! echo "$1" | grep -Eq '^[+-]?[0-9]+(\.[0-9]+)?$'; then
    echo "Error: Delta must be a number"
    exit 1
fi

# Get the current cursor zoom factor
current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk -F': ' '{print $2}')

# Calculate the new zoom factor
new_zoom=$(echo "$current * $1" | bc)

# Ensure the new zoom factor is at least 1.0
if [ "$(echo "$new_zoom < 1.0" | bc)" -eq 1 ]; then
    new_zoom=1.0
fi

# Set the new cursor zoom factor
hyprctl keyword cursor:zoom_factor "$new_zoom"
