#!/bin/bash


# toggle the wifi connection
wifiStatus=$(nmcli radio wifi)

if [[ ($1 == "toggleWifi" && $wifiStatus == "enabled")  ]]
then
    nmcli radio wifi off
elif [[ ($1 == "toggleWifi" && $wifiStatus == "disabled" ) || -z `nmcli con show --active | grep ethernet` ]]
then
    # nmcli connect delete MyNetwork #delete existing connection
    nmcli radio wifi on
    # nmcli device wifi connect MyNetwork password "MYPASS" #reconnect
else
    nmcli radio wifi off
fi
