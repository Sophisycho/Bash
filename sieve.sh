#!/bin/bash 


INPUT=$1
PRIME=()

is_prime(){
    local num=$1
    if (( num < 2 )); then
        return 1
    fi
    for (( i=2; i*i<=num; i++ )); do
        if (( num % i == 0 )); then
            return 1
        fi
    done
    return 0 # 這個return 0不能放在前面的if語句的else裡面，因為跑迴圈一定會有沒除盡的時候，放在這裡表示迴圈跑完如果都沒有return 1就是質數
}

for (( j=2; j<=$INPUT; j++ )); do
    if is_prime $j; then
        PRIME+=($j)
    fi
done

echo ${PRIME[@]}
