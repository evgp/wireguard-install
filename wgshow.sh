#!/usr/bin/bash

WG_CONFIG=/etc/wireguard/wg0.conf
WG_SHOW=$(wg show)
IFS=$'\n'

for line in $WG_SHOW 
do
        if echo $line | grep -q "peer"; then
                PEER=$(echo $line | awk '{print $NF}')
                COMMENT=$(cat $WG_CONFIG | grep -B 2 $PEER | head -n 1 | awk '{print $NF}')
                echo $line \# $COMMENT
        else
                echo $line
        fi
done
