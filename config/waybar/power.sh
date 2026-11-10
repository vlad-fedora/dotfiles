#!/usr/bin/env bash
choice=$(printf "Logout\nReboot\nShutdown" | rofi -dmenu -p "Power")
case "$choice" in
  Logout)   loginctl terminate-user "$USER" ;;
  Reboot)   systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
