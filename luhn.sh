#!/bin/bash

INPUT="$*"
LEN=${#INPUT}
SUM_ODD=0
SUM_EVEN=0
OUT_ARRAY=()
IN_ARRAY=()


INPUT=$(echo "$INPUT" | tr -d " ")
LEN=${#INPUT}

if [[ ! "$INPUT" =~ ^[0-9]+$ ]];then
    echo "false"
    exit
fi
if [[ "$LEN" -lt 2 ]]; then
    echo "false"
    exit
fi

formatted_input=$(printf "%016s" $INPUT)
formatted_input=${formatted_input// /0}
#echo $formatted_input
LEN_FORMATTED=${#formatted_input}

# 單數先加起來
total_odd() {
    for (( i=1; i<"$LEN_FORMATTED"; i+=2 )); do
        odd=${formatted_input:$i:1}
        SUM_ODD=$(( SUM_ODD + odd ))
    done
    echo "單數加起來的數字是:${SUM_ODD}"
}



# 雙數分配到不同的ARRAY之後再做處理

array_even() {
    for (( i=0; i<"$LEN_FORMATTED"; i+=2 ));do
        even=${formatted_input:$i:1}
        if [[ "$even" -lt 5 ]]; then
            IN_ARRAY+=("$even")
        else
            OUT_ARRAY+=("$even")
        fi
    done
    echo "這是不會爆的陣列:${IN_ARRAY[@]}"
    echo "這是會爆的陣列:${OUT_ARRAY[@]}"
}




# 處理x2會爆的ARRAY
OUT_FINAL=0
calcul_out_array() {
    for element in "${OUT_ARRAY[@]}"; do
        final=$(( element*2-9%10 ))
        OUT_FINAL=$(( OUT_FINAL + final ))
    done
    echo "會爆的陣列*2-9%10後的數字$OUT_FINAL"
}

# 會爆的ARRAY和不會爆的相加
IN_FINAL=0
calcul_in_array() {
    for element in "${IN_ARRAY[@]}"; do
        IN_FINAL=$(( IN_FINAL + element*2  ))
    done
    echo "不會爆的陣列相加總共:$IN_FINAL"
}


# 最後加起來除十
final_count() {
    total=$(( OUT_FINAL + IN_FINAL + SUM_ODD ))
    if [[ $(( total%10 )) -eq 0 ]]; then
        echo "true"
    else
        echo "false"
    fi
}


total_odd
array_even
calcul_out_array
calcul_in_array
final_count

