#!/bin/bash

readable() {
  local bytes=$1
  local kib=$(( bytes >> 10 ))
  local mib=$(( kib >> 10 ))
  if [ $kib -lt 0 ]; then
    echo "? K"
  elif [[ $kib -gt 1024 && $mib -lt 1024 ]]; then
    local mib_int=$(( kib >> 10 ))
    local mib_dec=$(( kib % 1024 * 976 / 10000 ))
    if [ "$mib_dec" -lt 10 ]; then
      mib_dec="0${mib_dec}"
    fi
    echo "${mib_int}.${mib_dec} M"
  elif [ $mib -ge 1024 ]
  then
    local gib_int=$(( mib >> 10 ))
    local gib_dec=$(( mib % 1024 * 976 / 10000 ))
    if [ "$gib_dec" -lt 10 ]; then
      gib_dec="0${gib_dec}"
    fi
    echo "${gib_int}.${gib_dec} G"
  else
    echo "${kib} K"
  fi
}


for f in `ls ~/log/*.json`
do
    [[ ! -r $f ]] && echo "cannot read file $f."&& break
    echo "######## ${f##*/} ########"


    totaljson=$(cat $f)
    #totaljson=$(cat $f | sed '$ s/.$/]/')
    # write [ and ] at the start and end of the text to decalre it as an array of json
    [[ -z $(head -c 1 $f | grep '\[') ]] && totaljson=$(echo "[$totaljson")
    [[ -n $(tail -c 2 $f | grep ',')  ]] && totaljson=$(echo $totaljson | sed '$ s/.$//')
    [[ -z $(tail -c 2 $f | grep '\]') ]] && totaljson=$(echo "$totaljson]")


    if [[ $1 == "-v" ]]
    then
        echo -e "date, \t\t\t\tuptime\t\ttotal download";


        echo $totaljson | jq '.[] | [.date,.uptime,.total_download.human] | @csv' | tr -d '\\"' | grep --color -E "[[:digit:]]* hour.||[[:digit:]]* minutes"
    fi

    #maxD=0
    #minD=99999999999
    #  [[ $minD > $num ]] && minD=$num;[[ $maxD < $num ]] && maxD=$num;
    sumDown=0
    sumUP=0
    for num in `echo $totaljson | jq -r '.[].total_download.bytes'`;do sumDown=$((sumDown+num));done
    for num in `echo $totaljson | jq -r '.[].total_upload.bytes'`;do sumUP=$((sumUP+num));done

    echo "Total Download: " $(readable ${sumDown})
    echo "Total Upload: " $(readable ${sumUP})
#    echo "Maximum Download: " $(readable ${maxD})
#    echo "Minimum Download: " $(readable ${minD})
    #cat sessionStat.json | sed '$ s/.$/]/' | jq '.[].total_download.human'
done
