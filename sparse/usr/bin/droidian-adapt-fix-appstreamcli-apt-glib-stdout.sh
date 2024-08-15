#!/bin/sh

## Log
ADAPTATION_LOG="/var/log/droidian-adaptation/droidian-adaptation-xiaomi-vayu.log"
echo "$(date +'%Y-%m-%d %H:%M:%S') Executing droidian-berb-fix-appstreamcli-apt-glib-stdout..." | tee -a "${ADAPTATION_LOG}"

## Patch 50appstream file to hide some glib errors from stdout when an apt-get update is permormed
file_to_patch='/etc/apt/apt.conf.d/50appstream'
pattern_search='then appstreamcli refresh --source=os > /dev/null \|\|'
pattern_replace='then appstreamcli refresh --source=os > /dev/null 2>%1 \|\|'
#sed -i "s|$(echo "$pattern_search")|$(echo "$pattern_replace")|g" "${file_to_patch}"

exit 0
