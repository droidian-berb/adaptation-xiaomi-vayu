#!/bin/sh

# TOOT_VERSION 1.0.0.1
## Script service to set the screen brightnes to 50% after phosh is started
#
# Copyright (C) 2024 Berbascum <berbascum@ticv.cat>
# All rights reserved.
#
# BSD 3-Clause License


## Log
ADAPTATION_LOG="/var/log/droidian-adaptation/droidian-adaptation-xiaomi-vayu.log"
echo "$(date +'%Y-%m-%d %H:%M:%S') Fixing brightness..." | tee -a "${ADAPTATION_LOG}"

brigth_max=$(cat /sys/class/backlight/backlight/max_brightness)
[ -z "${brigth_max}" ] && exit 1

bright_to_set=$((brigth_max / 2))

echo "brigth_max = ${brigth_max}" | tee -a "${ADAPTATION_LOG}"
echo "bright_to_set = ${bright_to_set}" | tee -a "${ADAPTATION_LOG}"

#echo "2000" | tee /sys/class/backlight/backlight/brightness
#echo "2000" | tee /sys/class/backlight/panel0-backlight/brightness
echo "${bright_to_set}" | tee /sys/class/backlight/backlight/brightness
echo "${bright_to_set}" | tee /sys/class/backlight/panel0-backlight/brightness

exit 0
