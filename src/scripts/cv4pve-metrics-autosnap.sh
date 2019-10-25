#
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
# Save martrics for autosnap on database $INFULX_DB_NAME

INFULX_DB_HOST=""
INFULX_DB_PORT="8086"
INFULX_DB_NAME="proxmox"
INFULX_DB_USER=""
INFULX_DB_PASSWORD=""

if [[ $CV4PVE_AUTOSNAP_PHASE == "snap-create-abort" ]] || [[ $CV4PVE_AUTOSNAP_PHASE == "snap-create-post" ]]; then
    local success=0
    [[ $CV4PVE_AUTOSNAP_PHASE == "snap-create-post" ]] && success=!

    #url post
    local url="http://$INFULX_DB_HOST:$INFULX_DB_PORT/write?db=$INFULX_DB_NAME"

    #data metrics
    local data="autosnap,host=$HOSTNAME,vmid=$CV4PVE_AUTOSNAP_VMID,type=$CV4PVE_AUTOSNAP_VMTECHNOLOGY host=$HOSTNAME,vmid=$CV4PVE_AUTOSNAP_VMID,type=$CV4PVE_AUTOSNAP_VMTECHNOLOGY,success=$success"

    if [[ $INFULX_DB_USER == "" ]]; then
        #no login
        curl -s -i -XPOST "$url" --data-binary "$data"
    else
        #with login
        curl -s -i -XPOST -u $INFULX_DB_USER:$INFULX_DB_PASSWORD "$url" --data-binary "$data"
    fi
fi
