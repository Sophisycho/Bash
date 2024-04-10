#!/bin/bash


SYMBOL=$1
SYMBOL_NUM=${#1}
LEFT_BRACES_NUM=0
LEFT_BRACKET_NUM=0
LEFT_PARTHE_NUM=0
LEFT_BRACES_INDEX=()
LEFT_BRACKET_INDEX=()
LEFT_PARTHE_INDEX=()

RIGHT_BRACES_NUM=0
RIGHT_BRACKET_NUM=0
RIGHT_PARTHE_NUM=0
RIGHT_BRACES_INDEX=()
RIGHT_BRACKET_INDEX=()
RIGHT_PARTHE_INDEX=()

# 先把輸入的參數一個一個抓出來
for (( i=0; i<$SYMBOL_NUM; i++ )); do
    CHAR_i=${SYMBOL:i:1}
    # 如果是 { 的話記錄一下 { 的數量，並且記錄 { 的index
    if [[ $CHAR_i == '{' ]]; then
        LEFT_BRACES_NUM=$(( LEFT_BRACES_NUM+1 ))
        LEFT_BRACES_INDEX+=("$i")
    elif
        [[ $CHAR_i == '[' ]]; then
        LEFT_BRACKET_NUM=$(( LEFT_BRACKET_NUM+1 ))
        LEFT_BRACKET_INDEX+=("$i")
    elif
        [[ $CHAR_i == '(' ]]; then
        LEFT_PARTHE_NUM=$(( LEFT_PARTHE_NUM+1 ))
        LEFT_PARTHE_INDEX+=("$i")
    fi
done

echo "左 { 數量: $LEFT_BRACES_NUM"
echo "左 { INDEX: ${LEFT_BRACES_INDEX[@]}"

echo "左 [ 數量: $LEFT_BRACKET_NUM"
echo "左 [ INDEX: ${LEFT_BRACKET_INDEX[@]}"

echo "左 ( 數量: $LEFT_PARTHE_NUM"
echo "左 ( INDEX: ${LEFT_PARTHE_INDEX[@]}"


# 找右邊的 }
for (( j=0; j<${SYMBOL_NUM}; j++ )); do
    CHAR_j=${SYMBOL:j:1}
    if [[ $CHAR_j == '}' ]]; then
        RIGHT_BRACES_NUM=$(( RIGHT_BRACES_NUM+1 ))
        RIGHT_BRACES_INDEX+=("$j")
        elif
            [[ $CHAR_j == ']' ]]; then
        RIGHT_BRACKET_NUM=$(( RIGHT_BRACKET_NUM+1 ))
        RIGHT_BRACKET_INDEX+=("$j")
    elif
        [[ $CHAR_j == ')' ]]; then
        RIGHT_PARTHE_NUM=$(( RIGHT_PARTHE_NUM+1 ))
        RIGHT_PARTHE_INDEX+=("$j")
    fi
done

echo "右 } 數量: $RIGHT_BRACES_NUM"
echo "右 } INDEX: ${RIGHT_BRACES_INDEX[@]}"

echo "右 ] 數量: $RIGHT_BRACKET_NUM"
echo "右 ] INDEX: ${RIGHT_BRACKET_INDEX[@]}"

echo "右 ) 數量: $RIGHT_PARTHE_NUM"
echo "右 ) INDEX: ${RIGHT_PARTHE_INDEX[@]}"


# 比對是否成雙成對，且順序正確
BRACES_WRONG_NUM=0

# 如果左 { 數量 = 右 } 數量
if [[ $LEFT_BRACES_NUM == $RIGHT_BRACES_NUM ]]; then
    # 比較右邊括號INDEX 是否大於左邊
    for (( k=0; k<${#LEFT_BRACES_INDEX[@]}; k++ )); do
        if (( ${RIGHT_BRACES_INDEX[$k]} > ${LEFT_BRACES_INDEX[$k]} )); then
            BRACES_WRONG_NUM=$(( BRACES_WRONG_NUM+0 ))
        else
            # 如果右邊括號INDEX 小於左邊，數字+1
            BRACES_WRONG_NUM=$(( BRACES_WRONG_NUM+1 ))
        fi
    done
else
    BRACES_WRONG_NUM=$(( BRACES_WRONG_NUM+1 ))
fi



if [[ $BRACES_WRONG_NUM > 0  ]]; then
    echo "{}錯誤數量大於零: $BRACES_WRONG_NUM"
else
    echo "{}格式正確，錯誤數量為: $BRACES_WRONG_NUM"
fi


BRACKET_WRONG_NUM=0

# 如果左 [ 數量 = 右 ] 數量
if [[ $LEFT_BRACKET_NUM == $RIGHT_BRACKET_NUM ]]; then
    # 比較右邊括號INDEX 是否大於左邊
    for (( l=0; l<${#LEFT_BRACKET_INDEX[@]}; l++ )); do
        if (( ${RIGHT_BRACKET_INDEX[$l]} > ${LEFT_BRACKET_INDEX[$l]} )); then
            BRACKET_WRONG_NUM=$(( BRACKET_WRONG_NUM+0 ))
        else
            echo "${RIGHT_BRACKET_INDEX[$l]}"
            echo "${LEFT_BRACKET_INDEX[$l]}"

            # 如果右邊括號INDEX 小於左邊，數字+1
            BRACKET_WRONG_NUM=$(( BRACKET_WRONG_NUM+1 ))
        fi
    done
else
    BRACKET_WRONG_NUM=$(( BRACKET_WRONG_NUM+1 ))
fi





if [[ $BRACKET_WRONG_NUM > 0  ]]; then
    echo "[]錯誤數量大於零: $BRACKET_WRONG_NUM"
else
    echo "[]格式正確，錯誤數量為: $BRACKET_WRONG_NUM"
fi

PARTHE_WRONG_NUM=0

# 如果左 ( 數量 = 右 ) 數量
if [[ $LEFT_PARTHE_NUM == $RIGHT_PARTHE_NUM ]]; then
    # 比較右邊括號INDEX 是否大於左邊
    for (( m=0; m<${#LEFT_PARTHE_INDEX[@]}; m++ )); do
        if (( ${RIGHT_PARTHE_INDEX[$m]} > ${LEFT_PARTHE_INDEX[$m]} )); then
            PARTHE_WRONG_NUM=$(( PARTHE_WRONG_NUM+0 ))
        else
            # 如果右邊括號INDEX 小於左邊，數字+1
            PARTHE_WRONG_NUM=$(( PARTHE_WRONG_NUM+1 ))
        fi
    done
else
    PARTHE_WRONG_NUM=$(( PARTHE_WRONG_NUM+1 ))
fi





if [[ $PARTHE_WRONG_NUM > 0  ]]; then
    echo "()錯誤數量大於零: $PARTHE_WRONG_NUM"
else
    echo "()格式正確，錯誤數量為: $PARTHE_WRONG_NUM"
fi

# 最小INDEX的括號的右括號應該要是最大INDEX
FIN_CHECK=0
if (( BRACES_WRONG_NUM + BRACKET_WRONG_NUM + PARTHE_WRONG_NUM  == 0)); then
    if [[ -n ${LEFT_BRACES_INDEX[@]} ]]; then
        for ((a = 0; a < ${#LEFT_BRACES_INDEX[@]}; a++)); do
            max=0
            max_name=""
            if [[ -n ${RIGHT_BRACES_INDEX[@]} ]]; then
                max=${RIGHT_BRACES_INDEX[a]}
            fi
            if [[ -n ${RIGHT_BRACKET_INDEX[@]} ]] && [[ -n ${RIGHT_PARTHE_INDEX[@]} ]]; then
                if (( ${RIGHT_BRACKET_INDEX[a]} > max )); then
                    max=${RIGHT_BRACKET_INDEX[a]}
                    if (( ${RIGHT_PARTHE_INDEX[a]} > max )); then
                        max=${RIGHT_PARTHE_INDEX[a]}
                    fi
                elif (( ${RIGHT_PARTHE_INDEX[a]} > max )); then
                    max=${RIGHT_PARTHE_INDEX[a]}
                fi
            fi
            if [[ ${LEFT_BRACES_INDEX[a]} == 0 ]]; then
            max_name="RIGHT_BRACES_INDEX"
            fi
            if [[ ${LEFT_BRACKET_INDEX[a]} == 0 ]]; then
                max_name="RIGHT_BRACKET_INDEX"
            fi
            if [[ ${LEFT_PARTHE_INDEX[a]} == 0 ]]; then
                max_name="RIGHT_PARTHE_INDEX"
            fi
            if [[ -n $max_name ]]; then
                echo "At position $a, the largest value among RIGHT_* indexes is $max from $max_name"
                if [[ $max_name == "RIGHT_BRACES_INDEX" && ${RIGHT_BRACES_INDEX[@]} -eq $max ]]; then
                    FIN_CHECK=0
                elif [[ $max_name == "RIGHT_BRACKET_INDEX" && ${RIGHT_BRACKET_INDEX[@]} -eq $max ]]; then
                    FIN_CHECK=0
                elif [[ $max_name == "RIGHT_PARTHE_INDEX" && ${RIGHT_PARTHE_INDEX[a]} -eq $max ]]; then
                    FIN_CHECK=0
                else
                    ((FIN_CHECK++))
                fi
            fi
        done
    fi
fi

# 全部格式是否正確
if (( BRACES_WRONG_NUM + BRACKET_WRONG_NUM + PARTHE_WRONG_NUM + FIN_CHECK == 0 )); then
    echo "全部格式正確"
else
    echo "格式不正確"
fi
