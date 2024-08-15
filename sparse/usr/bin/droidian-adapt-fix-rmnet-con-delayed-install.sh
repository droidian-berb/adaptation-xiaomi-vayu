#!/bin/bash

# TOOL_VERSION = 1.0.1
#
# Upstream-Name: rmnet-con-delayed installer
# Source: https://github.com/droidian-vayu/adaptation-xiaomi-vayu
#
## Script service to monitor changes on rfkill devices and restart the bluetooth service if bluetoothctl is hung
#
# Copyright (C) 2024 Berbascum <berbascum@ticv.cat>
# All rights reserved.
#
# BSD 3-Clause License

## Log
ADAPTATION_LOG="/var/log/droidian-adaptation/droidian-adaptation-xiaomi-vayu.log"
echo "$(date +'%Y-%m-%d %H:%M:%S') Installing rmnet connection fix script..." | tee -a "${ADAPTATION_LOG}"

for profile in $(find /home -name ".profile"); do
    fix_enabled=$(cat $profile | grep "sleep 10 && /usr/bin/droidian-adapt-fix-rmnet-con-delayed.sh")
    if [ -z "${fix_enabled}" ]; then
        echo "" >> ${profile}
        echo "## Fix rmnet connection" >> ${profile}
        echo "(sleep 10 && /usr/bin/droidian-adapt-fix-rmnet-con-delayed.sh) &" >> ${profile}
    fi
done

exit 0
