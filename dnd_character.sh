#!/bin/bash

modifi(){
    MOD=$(echo "scale=2; ($1 - 10) / 2" | bc -l)
    NEG_INT_MOD=$( echo "($1 - 10) / 2 " | bc)
    POS_INT_MOD=$( echo "($1 - 10) / 2 " | bc | tr -d '-' )
    echo "MOD: $MOD"
    echo "負整數部分: ${NEG_INT_MOD}"
    echo "正整數部分: ${POS_INT_MOD}"
    INTERPOL=$(echo "$MOD - $NEG_INT_MOD" | bc)
    if [[ $MOD =~ ^- ]] && [[ $INTERPOL != 0  ]]; then
        FIN_MOD=$(( NEG_INT_MOD -1 ))
    elif
        [[ $MOD =~ ^- ]]; then
        FIN_MOD=$NEG_INT_MOD
    else
        FIN_MOD=$POS_INT_MOD
    fi
    echo "$FIN_MOD"
}
if [[ $1 == modifier ]]; then
    modifi $2
fi



# 四顆六面骰取最大的三個數
dice() {
    local array=()
    for (( i=0; i<4; i++ )); do
        DICE_NUM=$((RANDOM % 6 + 1))
        array+=($DICE_NUM)
    done
    echo "${array[@]}"
}

sorted_select_top3() {
    local array=("$@")
    local sorted_array=($(echo "${array[@]}" | tr ' ' '\n' | sort -r | tr '\n' ' '))  
    # 這邊如果最外面不用括號再包起來會變成$(command)結果是一個字串而不是一個數組
    echo "${sorted_array[*]:0:3}"
}

sum(){
    local sorted_array=("$@")
    local sum=0
    for (( i=0; i<3; i++ )); do
        sum=$(( sum + ${sorted_array[i]} ))
        # 這裡不能用+= 不然他會單純把數字拼接起來而不是加起來
    done
    echo "$sum"
}

result(){
    local dice_rolls=($(dice))
    local top3=($(sorted_select_top3 "${dice_rolls[@]}"))
    local total=$(sum "${top3[@]}")
    echo "您的人物初始 ${1} 素質為:${total}"
    if [[ $1 == 'CON' ]]; then
        CON_TOTAL=$total
    fi
}

if [[ $1 == generate ]]; then
    for i in STR DEX CON INT WIS CHA HIT; do
        if [[ $i == 'HIT' ]]; then
            modifi $CON_TOTAL
            HITPOINT=$(( 10 + $FIN_MOD))
            echo "您的人物初始 ${i} 素質為:${HITPOINT}"
        else 
            result $i
        fi
    done
fi
