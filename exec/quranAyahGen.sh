#!/bin/bash

API_URL="http://api.alquran.cloud/v1/ayah"

tashkeel=( '\u064b' '\u064f' '\u064c' '\u0652' '\u064d' '\u0650' '\u0651' '\u064e' )

while true
do

    ayah=$(curl $API_URL/$(shuf -i 1-6236 -n 1))
    echo $ayah | jq '.data.text'| tr -d '"' > $HOME/.config/quranAyah

    sleep 100
done
