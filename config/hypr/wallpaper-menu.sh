#!/usr/bin/env bash
DIR="$HOME/Pictures/wallpapers"

choice=$(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) -printf '%f\n' | sort | while read -r name; do
  printf '%s\0icon\x1f%s\n' "$name" "$DIR/$name"
done | rofi -dmenu -show-icons -p "Wallpaper" \
  -theme-str 'window {width: 60%;} listview {columns: 3; lines: 2;} element {orientation: vertical;} element-icon {size: 10em;}')

[ -z "$choice" ] && exit 0
"$HOME/.config/hypr/wallpaper.sh" "$DIR/$choice"
