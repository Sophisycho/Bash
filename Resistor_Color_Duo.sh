#!/bin/bash


declare -A band
band[black]=0
band[brown]=1
band[red]=2
band[orange]=3
band[yellow]=4
band[green]=5
band[blue]=6
band[violet]=7
band[grey]=8
band[white]=9


NO_SPACE_INPUT=$(echo "$*" | tr " " "-")

ORI_INPUT=$NO_SPACE_INPUT
ORI_CHA_NUM=${#ORI_INPUT}
dash_num=0


for (( i=0; i<$ORI_CHA_NUM; i++ )); do
    char=${ORI_INPUT:i:1}
    # echo $char
    if [[ $char == '-' ]]; then
        dash_num=$(( dash_num+1 ))
    fi
done
# echo "$dash_num"

if [[ $dash_num > 1 ]]; then
    INPUT=$(echo "$ORI_INPUT" | awk -F '-' '{print $1 "-" $2}')
    key1=${INPUT%-*}
    key2=${INPUT#*-}
    value1=${band[$key1]}
    value2=${band[$key2]}
    echo "${value1}${value2}"
else
    key1=${ORI_INPUT%-*}
    key2=${ORI_INPUT#*-}
    value1=${band[$key1]}
    value2=${band[$key2]}
    echo "${value1}${value2}"

fi
