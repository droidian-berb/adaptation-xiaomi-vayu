# adaptation-xiaomi-vayu
Package needed to boot Droidian on a Xiaomi Pocophone X3 Pro


## Fixes information

### Squeekboard takes too long to appear
Squeekboard seems to be executed as a desktop link in /usr/share/applications (there is two destop links related: sm.puri.OSK0.desktop and sm.puri.Squeekboard.desktop)
The problem is not a squeekboard related, is a problem with the phosh autostart applications which delays the executions too long.
To solve the problem for squeekboard, the user .profiles found, are configured to call the binary.
To avoid a crash when the desktop links are executed, the binare is renamed to squeekboard2

### # Autorestart bluetooth service 
May happen that the bluetooth service hangs if the controller is managed from the Phosh GUI until the bluetooth service is restarted.
For this cases, this fix monitors the bluetooth service and auto-restart it when some event on rfkill devices is detected, and the bluetooth service is not responding. 

Also the file /var/lib/bluetooth/inotify-macs.allow can be used to add device MACs (one per line), and the autorestart will be done on every rfkill event detection if some device registeered MAC is on the .allow file

The service is enabled by default, if problems are detected, stop and disable the droidian-xiaomi-vayu-inotify-bluetooth.service

A log registry is writed every time the bluetooth service is autorestarted (/var/log/bluetooth-inotify.log)

