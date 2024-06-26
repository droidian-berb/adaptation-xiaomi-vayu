#!/bin/sh

## Log
ADAPTATION_LOG="/var/log/droidian-adaptation/droidian-adaptation-xiaomi-vayu.log"
echo "$(date +'%Y-%m-%d %H:%M:%S') Executing droidian-berb-fix-flash-bootimage-xiaomi-vayu..." | tee -a "${ADAPTATION_LOG}"

## Fix getprop binary call
sed -i 's|^GETPROP="$(choose_application.*|GETPROP="/usr/bin/getprop"|g' /usr/sbin/flash-bootimage
## Use .device property instead .model
sed -i 's/device_model=$(${GETPROP} ro.product.vendor.model/device_model=$(${GETPROP} ro.product.vendor.device/g' /usr/sbin/flash-bootimage

exit 0
