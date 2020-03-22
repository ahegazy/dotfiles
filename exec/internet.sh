#!/bin/bash

if [[ -z `nmcli con show --active | grep ethernet` ]] #if ethernet is not active connect to wifi
then
    nmcli radio wifi on
    # nmcli connect delete myNetwork #delete existing connection, doesnot work without it
    nmcli device wifi connect myNetwork password MyComplexPass #reconnect
else
    nmcli radio wifi off
fi
