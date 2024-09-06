#! /usr/bin/bash

opened=0

while read -r line; do
    if [ "$line" = "language-win: language-win" ]; then
        opened=1
    fi
done <<< $(eww active-windows)

if [[ $opened -eq 0 ]]; then
    eww open language-win
    sleep 1
    eww close language-win
else
    pids=$(ps aux | grep langWinToggler.sh | grep -v grep | awk '{print $2}')

    for pid in $pids; do
        if [[ $pid -ne $$ ]]; then
            kill -9 $pid
        fi
    done

    sleep 1
    eww close language-win
fi
