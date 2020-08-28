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
# Save metrics for vzdump on database InfluxDB
#
# edit /etc/vzdump.conf and change tag "script:" with this script
#
# see https://pve.proxmox.com/pve-docs/vzdump.1.html

INFLUXDB_HOST=""
INFLUXDB_PORT="8086"
INFLUXDB_NAME="db_proxmox"
INFLUXDB_USER=""
INFLUXDB_PASSWORD=""

phase="$1"
mode="$2"
vmid="$3"

if [ "$phase" == "log-end" ]; then
    success=0
    duration=0
    size=0
    speed=0

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
    url="http://$INFLUXDB_HOST:$INFLUXDB_PORT/write?db=$INFLUXDB_NAME"

    #data metrics
    data="vzdump,host=$HOSTNAME,type=$VMTYPE,storeid=$STOREID,vmid=$vmid vmid=$vmid,success=$success,duration=$duration,speed=$speed,size=$size"

    if [[ $INFLUXDB_USER == "" ]]; then
        #no login
        curl -s -i -XPOST "$url" --data-binary "$data"
    else
        #with login
        curl -s -i -XPOST -u $INFLUXDB_USER:$INFLUXDB_PASSWORD "$url" --data-binary "$data"
    fi
fi