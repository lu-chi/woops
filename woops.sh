#!/usr/bin/env bash

iface=$(airmon-ng | grep wlan | awk '{print $2}')

start_mon() {
    for ((i=1; i<=$1; i++))
    do
        airmon-ng start ${iface}
    done
}

stop_mon() {
    imon=$(airmon-ng | grep mon | awk '{print $2}')
    for i in ${imon}
    do
        airmon-ng stop $i        
    done
}

create_session() {
    sn="woops"
    tmux new-session -s "$sn" -d
    for (( i=1; i<=$1; i++))
    do
        tmux new-window -t "$i"
        tmux send-keys -t "$i" "ls" C-m
    done
    tmux attach-session -d 
}

main() {
    start_mon $1
    create_session $1
}

main $1

