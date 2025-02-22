#!/usr/bin/env sh
current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk -F': ' '{print $2}')
if [ "$current" = "1.000000" ]; then
    hyprctl keyword cursor:zoom_factor 2.0
else
    hyprctl keyword cursor:zoom_factor 1.0
fi
