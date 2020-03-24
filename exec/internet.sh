#!/bin/bash

if [[ -z `nmcli con show --active | grep ethernet` ]]
then
    # nmcli connect delete MyNetwork #delete existing connection
    nmcli radio wifi on
    # nmcli device wifi connect MyNetwork password "MYPASS" #reconnect
else
    nmcli radio wifi off
fi
