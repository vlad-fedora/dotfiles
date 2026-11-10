#!/usr/bin/env bash
cache="/tmp/cliphist-thumbs"
mkdir -p "$cache"

make_list() {
  cliphist list | while IFS=$'\t' read -r id content; do
    if [[ "$content" =~ ^\[\[\ binary.*(png|jpg|jpeg|webp|bmp) ]]; then
      f="$cache/$id.png"
      [ -f "$f" ] || echo "$id" | cliphist decode > "$f"
      printf '%s\t%s\0icon\x1f%s\n' "$id" "$content" "$f"
    else
      printf '%s\t%s\n' "$id" "$content"
    fi
  done
}

while true; do
  sel=$(make_list | rofi -dmenu -show-icons -p "Clipboard" \
    -kb-custom-1 "Alt+Delete" \
    -theme-str 'element-icon {size: 3.5em;}' \
    -mesg "Enter: copiază | Alt+Delete: șterge elementul")
  code=$?
  case $code in
    0)  [ -n "$sel" ] && echo "$sel" | cliphist decode | wl-copy; break ;;
    10) [ -n "$sel" ] && echo "$sel" | cliphist delete ;;
    *)  break ;;
  esac
done
