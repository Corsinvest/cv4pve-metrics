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
# Save metrics for autosnap on database InfluxDB

INFLUXDB_HOST=""
INFLUXDB_PORT="8086"
INFLUXDB_NAME="proxmox"
INFLUXDB_USER=""
INFLUXDB_PASSWORD=""

file_duration="/tmp/autosnap$CV4PVE_AUTOSNAP_VMID$CV4PVE_AUTOSNAP_LABEL"

if [[ $CV4PVE_AUTOSNAP_PHASE == "snap-create-pre" ]]; then
    echo `date +%s` > $file_duration
fi

if [[ $CV4PVE_AUTOSNAP_PHASE == "snap-create-abort" ]] || [[ $CV4PVE_AUTOSNAP_PHASE == "snap-create-post" ]]; then
    success=0
    [[ $CV4PVE_AUTOSNAP_PHASE == "snap-create-post" ]] && success=1

    duration=0; duration=$((`date +%s`-`sed '1q;d' $file_duration`))
    rm $file_duration

    #url post
    url="http://$INFLUXDB_HOST:$INFLUXDB_PORT/write?db=$INFLUXDB_NAME"

    #data metrics
    data="cv4pve-autosnap,vmid=$CV4PVE_AUTOSNAP_VMID,type=$CV4PVE_AUTOSNAP_VMTYPE,label=$CV4PVE_AUTOSNAP_LABEL,vmname=$CV4PVE_AUTOSNAP_VMNAME,success=$success success=$success,duration=$duration"

    if [[ $INFLUXDB_USER == "" ]]; then
        #no login
        curl -s -i -XPOST "$url" --data-binary "$data"
    else
        #with login
        curl -s -i -XPOST -u $INFLUXDB_USER:$INFLUXDB_PASSWORD "$url" --data-binary "$data"
    fi
fi
