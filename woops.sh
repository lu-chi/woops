#!/usr/bin/env bash


# functions:
# ---------
# start_mon
# stop_mon
# create_session


start_mon() {
    # start defined number of monitor interfaces

    iface=$(airmon-ng \
            | grep wlan \
            | awk '{print $2}' \
    )

    for ((i=1; i<=$1; i++))
    do
        airmon-ng start ${iface}
    done
}

stop_mon() {
    # stop all detected monitor interfaces

    imon=$(airmon-ng \
            | grep mon \
            | awk '{print $2}' \
    )

    for i in ${imon}
    do
        airmon-ng stop $i        
    done
}

create_session() {
    # --- MOCK FUNCTION ---
    # create tmux sessions
    # send mdk3 into each window
    # attach to the session

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
    # start_mon $1
    create_session $1
}

main $1

