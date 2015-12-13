#!/usr/bin/env bash


# functions:
# ---------
# start_mon
# stop_mon
# create_session



detect_wlan() {
    # detect all wlans available
    iface=($(airmon-ng | grep wlan | awk '{print $2}'))
 }

mac_spoof() {
    # spoof the existing wlan mac address
    intf=$1
    ifconfig $intf down
    macchanger -r $intf
    ifconfig $intf up
}

choose_wlan() {
    # choose wlan to work with 
    # in case of more wlans detected
    ln=0
    iface=($(airmon-ng | grep wlan | awk '{print $2}'))
    if [ ${#iface[@]} -gt 1 ]; then
        echo "Found ${#iface[@]} WLAN interfaces:"
        for i in ${iface[@]}
        do
            ln=$((ln+=1))
            echo "$ln. $i"
        done
        echo -n "Select interface:  "
        read answer
        echo ${iface[$answer-1]}
    fi
}

start_mon() {
    # start defined number of monitor interfaces
    iface=($(airmon-ng | grep wlan | awk '{print $2}'))
    for ((i=1; i<=$1; i++))
    do
        iw $iface interface add mon$i type monitor
    done
}

stop_mon() {
    # stop all detected monitor interfaces
    for i in $(ifconfig | grep mon | awk '{print $1}')
    do
        iw $i interface del
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

#start_mon $1
stop_mon
#create_session $1

