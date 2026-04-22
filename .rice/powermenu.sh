#!/bin/sh

chosen=$(printf "Shutdown\nRestart\nLock" | rofi -dmenu)

case "$chosen" in
  "Shutdown") systemctl poweroff ;;
  "Restart") systemctl reboot ;;
  "Lock") swaylock ;;
  *) exit 1 ;;
esac
