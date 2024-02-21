#!/bin/bash


# 1 2 4 8 16 32 64 128 
# 1 2 3 4 5  6  7  8

INPUT=$1
TOTAL=0

if [[ $INPUT == "total" ]]; then
    INPUT=64
    for (( i=0; i<$INPUT; i++ )); do
        TOTAL=$(echo "$TOTAL + 2^$i" | bc)
    done
    echo "$TOTAL"
elif [[ INPUT -eq 0 ]] || [[ INPUT -eq -1 ]] || [[  INPUT -gt 64 ]]; then
    echo "Error: invalid input"
elif [[  INPUT -ne 1  ]]; then
    ANSWER=$(echo "2^(($INPUT-1))" | bc)
    echo "$ANSWER"
else 
    echo "1"
fi


