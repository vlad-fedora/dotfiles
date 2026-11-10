#!/usr/bin/env bash
DIR="$HOME/Pictures/wallpapers"

if [ -n "$1" ]; then
  IMG="$1"
else
  IMG=$(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf -n 1)
fi

[ -z "$IMG" ] && exit 1

awww img "$IMG" --transition-type fade
wal -i "$IMG" -n -q

source "$HOME/.cache/wal/colors.sh"
mkdir -p "$HOME/.config/rofi"
cat > "$HOME/.config/rofi/colors.rasi" <<EOF
* {
  bg: ${background}E6;
  bgs: ${background};
  fg: ${foreground};
  accent: ${color4};
  urgent: ${color1};
}
EOF

c4="${color4:1}"
c5="${color5:1}"
c8="${color8:1}"
cat > "$HOME/.config/hypr/colors.lua" <<EOF
return {
  active1 = "rgba(${c4}ee)",
  active2 = "rgba(${c5}ee)",
  inactive = "rgba(${c8}aa)",
}
EOF
hyprctl reload

swaync-client -rs

pkill swayosd-server
swayosd-server > /dev/null 2>&1 & disown
pkill -USR1 kitty

pkill -SIGUSR2 waybar
