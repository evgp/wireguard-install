#!/usr/bin/bash

WG_CONFIG=/etc/wireguard/wg0.conf
WG_SHOW=$(wg show)
IFS=$'\n'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

for line in $WG_SHOW 
do
        if echo $line | grep -q "peer"; then
                PEER=$(echo $line | awk '{print $NF}')
                COMMENT=$(cat $WG_CONFIG | grep -B 2 $PEER | head -n 1 | awk '{print $NF}')
                echo -e "${GREEN} ${COMMENT} ${NC} ${YELLOW} ${line} ${NC}"
        else
                echo $line
        fi
done
