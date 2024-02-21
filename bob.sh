#!/bin/bash



# 全大寫的輸入會回答Whoa, chill out

# 全大寫+問號結尾就會clam down, I know what I am doing

# 沒輸入或是輸入一堆空白就是Fine be that way

# 其他輸入就是whatever

#-----------------------------------------------#

# 先檢查是否是沒輸入或是輸入一堆空白


input="$1"

cleaned_input=$(echo "$input" | sed 's/[^a-zA-Z0-9!?]//g')

echo "$cleaned_input"

if [[  -z "$cleaned_input"  ]]; then
    echo "Fine. Be that way!"
elif
   [[ "$cleaned_input" =~ ^[A-Z]+\?$  ]]; then
    echo "Calm down, I know what I'm doing!"
elif
   [[ "$cleaned_input" =~ ^[A-Z0-9]*[A-Z]+[A-Z0-9]*!?$  ]]; then
    echo "Whoa, chill out!"
elif
   [[  "$cleaned_input" =~ \?$ ]]; then
    echo "Sure."
else
    echo "Whatever."

fi
