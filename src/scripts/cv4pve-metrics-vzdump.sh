#!/bin/bash
#
# This file is part of the cv4pve-metrics https://github.com/Corsinvest/cv4pve-metrics,
#
# This source file is available under two different licenses:
# - GNU General Public License version 3 (GPLv3)
# - Corsinvest Enterprise License (CEL)
# Full copyright and license information is available in
# LICENSE.md which is distributed with this source code.
#
# Copyright (C) 2016 Corsinvest Srl	GPLv3 and CEL

#
# Save martrics for vzdump on database $INFULX_DB_NAME

INFULX_DB_HOST=""
INFULX_DB_PORT="8086"
INFULX_DB_NAME="proxmox"
INFULX_DB_USER=""
INFULX_DB_PASSWORD=""

local phase="$1" 
local mode="$2" 
local vmid="$3"

if [[ $phase == "log-end" ]]; then
    local success=0
    local duration=0
    local size=0
    local speed=0

    if [ `cat ${LOGFILE} | grep ERROR | wc -l` -eq 0 ]; then
        size=`stat -c%s $TARFILE`
        success=1
        speed=$((`cat ${LOGFILE} | grep -o -P "(?<=seconds \().*(?= MB/s)"`))
        if [ ! "$speed" -gt 0 ]; then
            speed=$(cat ${LOGFILE} | grep -o -P "(?<=.iB, ).*(?=.iB\/s)")
        fi
        duration=$((`cat ${LOGFILE} |grep -o -P "(?<=\()[0-9][0-9]:[0-9][0-9]:[0-9][0-9](?=\))"|awk -F':' '{print($1*3600)+($2*60)+$3}'`))
    fi

    #url post
    local url="http://$INFULX_DB_HOST:$INFULX_DB_PORT/write?db=$INFULX_DB_NAME"

    #data metrics
    local data="vzdump,host=$HOSTNAME,vmid=$vmid,type=$VMTYPE,storeid=$STOREID host=$HOSTNAME,vmid=$vmid,type=$VMTYPE,storeid=$STOREID,success=$success,duration=$duration,speed=$speed,size=$size"

    if [[ $INFULX_DB_USER == "" ]]; then
        #no login
        curl -s -i -XPOST "$url" --data-binary "$data"
    else
        #with login
        curl -s -i -XPOST -u $INFULX_DB_USER:$INFULX_DB_PASSWORD "$url" --data-binary "$data"
    fi
fi