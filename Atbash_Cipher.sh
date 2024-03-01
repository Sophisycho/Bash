#!/bin/bash


# 創建一個關聯式陣列，key是PLAIN；value是CIPHER
PLAIN=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
CIPHER=(z y x w v u t s r q p o n m l k j i h g f e d c b a)

declare -A MAP

for (( i=0; i<${#PLAIN[@]}; i++ )); do
    MAP[${PLAIN[$i]}]="${CIPHER[$i]}"
done

# echo "${MAP[*]}"



# 一個一個取出輸入的參數，並且檢查這個字元有沒有在陣列的key裡，如果有就取出值

ORI_INPUT=${2,,}
ORI_LEN=${#ORI_INPUT}
STRING=""

INPUT=$(echo "$ORI_INPUT" | tr -d ",. ")
LEN=${#INPUT}
for (( j=0; j<LEN; j++ )); do
    char=${INPUT:j:1}
    # echo "$char"
    if [[ -v MAP[$char] ]]; then
        STRING+=${MAP[$char]}
    else
        STRING+=$char
    fi
done

# echo "$STRING"




# 針對encode 的STRING 每五格插入一個空格

FIN_STRING=""
echo "$1"
if [[ $1 == 'encode' ]]; then
    for (( k=0; k<${#STRING}; k+=5 )); do
        if ((  k + 5 < ${#STRING} )); then
            FIN_STRING+="${STRING:k:5} "
        else
            FIN_STRING+="${STRING:k}"
        fi
    done
    echo "${FIN_STRING}"
else
    echo "${STRING}"
fi
