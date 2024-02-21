#!/bin/bash

input="$1"
# 將特殊字符替換為空格，並將所有字母轉為大寫
cleaned_input=$(echo "$input" | tr -s '[:punct:][:space:]' ' ' | tr '[:lower:]' '[:upper:]')

echo "$cleaned_input"

acronym=""
# 讀取處理後的輸入並從每個單詞提取首字母
for word in $cleaned_input; do
    first_letter=${word:0:1}
    acronym+="$first_letter"
done

echo "$acronym"
