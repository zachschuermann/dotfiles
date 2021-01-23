#!/usr/bin/env bash

# Terminate already running bar instances
# killall -q polybar
# If all your bars have ipc enabled, you can also use 
polybar-msg cmd quit

for m in $(polybar --list-monitors | cut -d":" -f1); do
    # echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
    # MONITOR=$m polybar top 2>&1 | tee -a /tmp/polybar1.log & disown
    # MONITOR=$m polybar bottom 2>&1 | tee -a /tmp/polybar2.log & disown

    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload bottom &
done


