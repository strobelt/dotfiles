#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

sleep .5
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload base &
  done
else
  polybar --reload base &
fi

