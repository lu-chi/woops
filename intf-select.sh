#!/usr/bin/env bash


# choose wlan to work with 
# in case of more wlans detected

ln=0
iface=($(ifconfig | grep "^en" | awk '{print $1}' | sed 's/://g'))

if [ ${#iface[@]} -gt 1 ]; then
    echo "Found ${#iface[@]} WLAN interfaces:"
    for i in ${iface[@]}
    do
        ln=$((ln+=1))
        echo "$ln. $i"
    done
    echo -n "Select interface:  "
    read answer
    echo "Selected interface [${iface[$answer-1]}]"
    ifconfig ${iface[$answer-1]} 
fi


