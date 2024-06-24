#!/bin/sh

## Script to fix a long delay until getting the squeekboard started
#
# Copyright (C) 2024 Berbascum <berbascum@ticv.cat>
# All rights reserved.
#
# BSD 3-Clause License

## Log
ADAPTATION_LOG="/var/log/droidian-adaptation/droidian-adaptation-xiaomi-vayu.log"
echo "$(date +'%Y-%m-%d %H:%M:%S') Executing droidian-berb-fix-squeekboard-delayed..." | tee -a "${ADAPTATION_LOG}"

[ -f "/usr/bin/squeekboard" ] && mv /usr/bin/squeekboard /usr/bin/squeekboard2

for profile in $(find /home -name ".profile"); do
    squeek_enabled=$(cat $profile | grep squeekboard2)
    if [ -z "${squeek_enabled}" ]; then
        echo "" >> ${profile}
        echo "## Call SqueekBoard"  >> ${profile}
        echo "(sleep 10 && /usr/bin/squeekboard2) &"  >> ${profile}
    fi
done

exit 0
