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

$INFLUXDB_HOST=""
$INFLUXDB_PORT="8086"
$INFLUXDB_NAME="proxmox"
$INFLUXDB_USER=""
$INFLUXDB_PASSWORD=""

$CV4PVE_AUTOSNAP_PHASE=$Env:CV4PVE_AUTOSNAP_PHASE
$CV4PVE_AUTOSNAP_VMID=$Env:CV4PVE_AUTOSNAP_VMID
$CV4PVE_AUTOSNAP_VMTYPE=$Env:CV4PVE_AUTOSNAP_VMTYPE
$CV4PVE_AUTOSNAP_LABEL=$Env:CV4PVE_AUTOSNAP_LABEL

$fileDuration=$env:TEMP + "autosnap$CV4PVE_AUTOSNAP_VMID$CV4PVE_AUTOSNAP_LABEL"

if ( $CV4PVE_AUTOSNAP_PHASE -eq "snap-create-pre" ){
    New-Item -ItemType "file" -Path $fileDuration -Force | Out-Null
}
 
if ( $CV4PVE_AUTOSNAP_PHASE -eq "snap-create-abort" -or $CV4PVE_AUTOSNAP_PHASE -eq "snap-create-post" ) {
    $success=0
    
    if ($CV4PVE_AUTOSNAP_PHASE -eq "snap-create-post") 
    {
        $success=1
    }

    $duration = [int](New-TimeSpan -Start (Get-ItemProperty -Path $fileDuration -Name LastWriteTime).LastWriteTime -End (Get-Date)).TotalSeconds

    #url post
    $url="http://$($INFLUXDB_HOST):$INFLUXDB_PORT/write?db=$INFLUXDB_NAME"

    #data metrics
    $data="cv4pve-autosnap,vmid=$CV4PVE_AUTOSNAP_VMID,type=$CV4PVE_AUTOSNAP_VMTYPE,label=$CV4PVE_AUTOSNAP_LABEL,success=$success success=$success,duration=$duration"

    if ( $INFLUXDB_USER -eq "" ) {
        #no login
        Invoke-WebRequest -Method Post -Body $data -Uri $url | Out-Null
    }
    else {
        #with login
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $INFLUXDB_USER,$INFLUXDB_PASSWORD)))
        Invoke-RestMethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Method Post -Body $data -Uri $url | Out-Null
    }
}