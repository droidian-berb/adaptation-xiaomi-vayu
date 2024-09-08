#!/bin/bash

## Some related check documentation
# gdbus introspect --system --dest org.freedesktop.ModemManager1 --object-path /org/freedesktop/ModemManager1/Modem/0 | grep PrimarySimSlot
  #interface org.freedesktop.ModemManager1.Modem 
     # properties:
       # readonly u PrimarySimSlot = 0;

# gdbus introspect --system --dest org.freedesktop.ModemManager1 --object-path /org/freedesktop/ModemManager1/Modem/0 | grep "PrimarySimSlot = " | awk '{print $NF}' | grep ';' | sed 's/;//g'

#qmicli -d qrtr://0 --uim-get-card-status
#### Primary GW:   slot '1', application '1'
#### Secondary GW: slot '2', application '1'

## Initial checks
qrtr-lookup | grep "MODEM:CMD" > /root/ofono-berb.log 2>&1
qmicli -d qrtr://0 --uim-get-card-status >> /root/ofono-berb.log 2>&1

fn_set_single_sim_slot() {
    sed "s/ExpectSlots = slot./ExpectSlots = slot${slot_num}/g" -i /etc/ofono/binder.conf
    sed "s/^\[slot.\]/[slot${slot_num}]/g" -i /etc/ofono/binder.conf
    sed "s/^slot = ./slot = ${stack_num}/g" -i /etc/ofono/binder.conf
}

## Ckeck slots for sim
slot1_has_sim=$(qmicli -d qrtr://0 --uim-get-card-status | grep "Primary GW" | grep "slot '1',")
slot2_has_sim=$(qmicli -d qrtr://0 --uim-get-card-status | grep "Secondary GW" | grep "slot '2',")

#echo "slot1_has_sim = $slot1_has_sim" >> /root/ofono-berb.log
#echo "slot2_has_sim = $slot2_has_sim" >> /root/ofono-berb.log

## TODO: dual-sim
if [ -n "${slot1_has_sim}" \
     -a -n "${slot2_has_sim}" ]; then
    sim_mode="dual-sim"
    slot_num="1"
    stack_num="0"
    echo "sim_mode = $sim_mode" >> /root/ofono-berb.log
    #fn_set_single_sim_slot
## single-sim
elif [ -n "${slot1_has_sim}" ]; then
    sim_mode="single1"
    slot_num="1"
    stack_num="0"
    echo "sim_mode = $sim_mode" >> /root/ofono-berb.log
    ## If slot with sim matches, no reconfigure
    slot_match=$(cat /etc/ofono/binder.conf | grep "slot1")
    echo "slot_match = ${slot_match}" >> /root/ofono-berb.log
    [ -n "${slot_match}" ] && exit 0
    fn_set_single_sim_slot
    ## Restart ofono to reload slot changes
    sleep 1
    systemctl restart ofono.service
    sleep 1
    systemctl restart ModemManager.service
elif [ -n "${slot2_has_sim}" ]; then
    sim_mode="single2"
    slot_num="2"
    stack_num="1"
    echo "sim_mode = $sim_mode" >> /root/ofono-berb.log
    ## If slot with sim matches, no reconfigure
    slot_match=$(cat /etc/ofono/binder.conf | grep "slot2")
    echo "slot_match = ${slot_match}" >> /root/ofono-berb.log
    [ -n "${slot_match}" ] && exit 0
    fn_set_single_sim_slot
    ## Restart ofono to reload slot changes
    sleep 1
    systemctl restart ofono.service
    sleep 1
    systemctl restart ModemManager.service
## default to slot1 if previous checks fail
else
    sim_mode="unknown"
    slot_num="1"
    stack_num="0"
    echo "sim_mode = $sim_mode" >> /root/ofono-berb.log
    #fn_set_single_sim_slot
fi

exit 0
