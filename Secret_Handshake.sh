#!/bin/bash

NUMBER=$1

BINARY=$(echo "obase=2; $NUMBER" | bc)
BINARY_NUM=${#BINARY}

echo "Decimal: $NUMBER"
echo "Binary: $BINARY"


declare -A ACTION=(
    [00001]='wink'
    [00010]='double blink'
    [00100]='close your eyes'
    [01000]='jump'
)



OPERATION=''
UNIT_NUM=00001
TEN_NUM=00010
HUNDRED_NUM=00100
THOUSAND_NUM=01000

UNIT=${BINARY: -1}
TEN=${BINARY: -2:1}
HUNDRED=${BINARY: -3:1}
THOUSAND=${BINARY: -4:1}
TEN_THOU=${BINARY: -5:1}

if [[ $TEN_THOU == 1 ]]; then
    for i in THOUSAND HUNDRED TEN UNIT; do
        if [[ ${!i} == 1 ]]; then
            NUM_VAR="${i}_NUM"
            OPERATION+="${ACTION[${!NUM_VAR}]},"  # 在後面加了一個逗點防止每次賦值時結果都黏在一起，也可以用空格
        fi
    done
else
    for i in UNIT TEN HUNDRED THOUSAND; do
        if [[ ${!i} == 1 ]]; then
            NUM_VAR="${i}_NUM"
            OPERATION+="${ACTION[${!NUM_VAR}]},"  # 在後面加了一個逗點防止每次賦值時結果都黏在一起，也可以用空格
        fi
    done
fi


# 移除最後一個逗點
OPERATION=${OPERATION%,}
echo "$OPERATION"
