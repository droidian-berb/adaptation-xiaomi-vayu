# adaptation-xiaomi-vayu
Package needed to boot Droidian on a Xiaomi Pocophone X3 Pro

## Fixes information

### droidian-adapt-fix-bluetooth-inotify-autorestart.service
May happen that the bluetooth service hangs if the controller is managed from the Phosh GUI until the bluetooth service is restarted.
For this cases, this fix monitors the bluetooth service and auto-restart it when some event on rfkill devices is detected, and the bluetooth service is not responding. 

Also there is the file /var/lib/bluetooth/inotify-macs.allow that can be used to add bluetooth device MACs (one per line), and the autorestart will be done on every rfkill event detection for that devices.

The service is enabled by default, if problems are detected, stop and disable the droidian-adapt-fix-bluetooth-inotify-autorestart.service

A log registry is writed every time the bluetooth service is autorestarted (/var/log/droidian-adaptation/droidian-adaptation-bluetooth-inotify-autorestart.log)

### droidian-adapt-fix-appstreamcli-apt-glib-stdout.service
This service hides some glib error messages in stdout when appstreamcli is called by apt-update

### droidian-adapt-fix-phosh-brightness-xiaomi-vayu.service
Sets the brightness to half after phosh is started since the device is booting with the value to 200 (very low)

### droidian-adapt-twk-ofono-qcom-single-sim-auto-selector.service
Tries to detect and configure the active slot on dual sim qcom devices for single sim configuration.

NOTE 1: Only tested on xiaomi vayu.
NOTE 2: Service on testing phase.

### droidian-perf.service
Enable sched tune for cpus management
