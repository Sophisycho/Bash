#!/bin/bash


# 輸入的參數會給定X、Y
X=$1
Y=$2
ARG=$(echo "$*" | tr -d ' '| tr -d '-' | tr -d '.')

if [[ -z $1 ]] || [[ -z $2 ]] || [[ $ARG =~ [^0-9] ]]; then 
    echo "要輸入兩個參數拉"
    exit 1
fi

# 計算座標到圓點的距離

DISTANCE=$(echo "scale=2; sqrt($X^2 + $Y^2)" | bc -l)

echo "$DISTANCE"


if [[ $(echo "$DISTANCE > 10" | bc) -eq 1 ]]; then
    POINT=0
elif
    [[ $(echo "$DISTANCE > 5" | bc) -eq 1 ]]; then
    POINT=1
elif 
    [[ $(echo "$DISTANCE > 1" | bc) -eq 1 ]]; then
    POINT=5
elif
    [[ $(echo "$DISTANCE <= 1" | bc) -eq 1 ]]; then
    POINT=10
fi

echo "你的得分是: $POINT"
