#!/usr/bin/env bash

# Terminate already running bar instances
# killall -q polybar
# If all your bars have ipc enabled, you can also use 
polybar-msg cmd quit

for i in /sys/class/hwmon/hwmon*/temp*_input; do
    if [ "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*}))" = "k10temp: Tctl" ]; then
        export HWMON_TCTL="$(readlink -f $i)"
    fi
    if [ "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*}))" = "k10temp: Tdie" ]; then
        export HWMON_TDIE="$(readlink -f $i)"
    fi
done

for m in $(polybar --list-monitors | cut -d":" -f1); do
    # echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
    # MONITOR=$m polybar top 2>&1 | tee -a /tmp/polybar1.log & disown
    # MONITOR=$m polybar bottom 2>&1 | tee -a /tmp/polybar2.log & disown

    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload bottom &
done


