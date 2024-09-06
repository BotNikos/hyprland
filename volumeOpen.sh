#! /usr/bin/bash

opened=0

while read -r line; do
    if [ "$line" = "volume-meter: volume-meter" ]; then
        opened=1
    fi
done <<< $(eww active-windows)

if [[ $opened -eq 0 ]]; then
    eww open volume-meter
    sleep 1
    eww close volume-meter
else
    pids=$(ps aux | grep volumeOpen.sh | grep -v grep | awk '{print $2}')

    for pid in $pids; do
        if [[ $pid -ne $$ ]]; then
            kill -9 $pid
        fi
    done

    sleep 1
    eww close volume-meter
fi
