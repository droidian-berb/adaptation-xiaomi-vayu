#!/bin/bash

## Log
ADAPTATION_LOG="/var/log/droidian-adaptation/droidian-adaptation-xiaomi-vayu.log"
echo "$(date +'%Y-%m-%d %H:%M:%S') Executing droidian-adapt-twk-apps-desktop-hide..." | tee -a "${ADAPTATION_LOG}"

## Hide the specified desktop links if found
links_to_hide=( "nvim.desktop" \
                "vim.desktop" )
links_path="/usr/share/applications"
 
hidden_str="NoDisplay=true"
visible_str="NoDisplay=false"
 
sed_replace_str() {
    src_str=$1
    dst_str=$2
    sed -i "s/${src_str}/${dst_str}/g" "${links_path}/${desk_link}"
}
 
for desk_link in ${links_to_hide[@]}; do
    is_hidden="$(cat "${links_path}/${desk_link}" | grep "${hidden_str}")"
    [ -n "${is_hidden}" ] && continue
    ## If not configured as hidden... 
    is_visible="$(cat "${links_path}/${desk_link}" | grep "${visible_str}")"
    if [ -n "${is_visible}" ]; then
        sed_replace_str "${visible_str}" "${hidden_str}"
        #echo "changed visible to hidden"
        continue
    fi
    ## If unconfigured...
    echo "${hidden_str}" >> "${links_path}/${desk_link}"
    #echo "adding hidden since previously unconfigured"
done
	
exit 0
