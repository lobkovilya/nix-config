#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/hyprpaper/wp"

# Build array of wallpapers
mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f)

# Get currently active wallpaper
CURRENT="$(hyprctl hyprpaper listloaded)"

echo "Current wallpaper is ${CURRENT}"

# Find current index
index=0
for i in "${!wallpapers[@]}"; do
  if [[ "${wallpapers[$i]}" == "$CURRENT" ]]; then
    index=$i
    break
  fi
done

# Get next index (wrap around)
next_index=$(((index + 1) % ${#wallpapers[@]}))

echo "Next wallpaper is ${wallpapers[$next_index]}"

# Apply
hyprctl hyprpaper reload ",${wallpapers[$next_index]}"
