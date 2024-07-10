#!/bin/bash

# TOOL_VERSION = 1.0.1
#
# Upstream-Name: rmnet-con-delayed
# Source: https://github.com/droidian-adaptations-berb/rmnet-con-delayed
#
## Script service to monitor changes on rfkill devices and restart the bluetooth service if bluetoothctl is hung
#
# Copyright (C) 2024 Berbascum <berbascum@ticv.cat>
# All rights reserved.
#
# BSD 3-Clause License

sleep 10

## Log
ADAPTATION_LOG="/var/log/droidian-adaptation/droidian-adaptation-xiaomi-vayu.log"
echo "$(date +'%Y-%m-%d %H:%M:%S') Starting rmnet connection fix script..." | tee -a "${ADAPTATION_LOG}"


rmnet_apns_num=$(nmcli c show | grep -c -E "gsm|cdma")
## TODO: More than 1 apn not supported
[ "${rmnet_apns_num}" -gt "1" ] && exit 0
rmnet_apn=$(nmcli c show | grep -E "gsm|cdma" | awk '{print $1}')
rmnet_modem=$(nmcli c show | grep -E "gsm|cdma" | awk '{print $NF}')

## Finish if not APN found
[ -z "${rmnet_apn}" ] && exit 0

## Check for sim unlock every 15 sec for 3 min to fix the connection
counter="1"
loop_sleep="10"
while [ "${counter}" -le "18" ]; do
    echo "rmnet fix loop every ${loop_sleep} secs, count number: \"${counter}\"..." | tee -a "${ADAPTATION_LOG}"
    sim_status=$(mmcli -m 0 -K | grep "^modem.generic.state" \
        | grep -v "failed" | awk '{print $NF}')
    echo "SIM status = ${sim_status}"
    if [ "${sim_status}" == "registered" ]; then
        echo "SIM registered, fixing the connection..." | tee -a "${ADAPTATION_LOG}"
        nmcli con down id "${rmnet_apn}" >/dev/null | tee -a "${ADAPTATION_LOG}"
        sleep 2
        nmcli con up id "${rmnet_apn}"  | tee -a "${ADAPTATION_LOG}"
        break
    fi
    counter=$((counter + 1))
    sleep ${loop_sleep}
done

exit 0
