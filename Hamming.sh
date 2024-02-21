#!/bin/bash


length_1=${#1}
length_2=${#2}
diff_num=0

if [[ $# -eq 0 ]] || [[ $# -eq 1 ]]; then
        echo "Usage: hamming.sh <string1> <string2>"
        exit 1
fi


if [[ $length_1 != "$length_2" ]]; then
        echo "strands must be of equal length"
        exit 1
fi

for (( counter=0; counter<length_1; counter++)); do
        char1=${1:$counter:1}
        char2=${2:$counter:1}
        if [[ $char1 != "$char2" ]]; then
                (( diff_num++ ))
        fi
done

echo "$diff_num"
