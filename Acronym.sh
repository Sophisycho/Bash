
#!/bin/bash


echo "$1" | awk '{
    result = "";
    gsub(/_/, "-");  # 將所有下劃線替換為連字符以統一處理
    gsub(/\*/, " ");  # 僅將星號替換為空格
    n = split($0, words, /[- ]+/);  # 根據空格或連字符分割整個輸入行到words數組
    for(i=1; i<=n; i++) {
        if (length(words[i]) > 0) {  # 忽略空字符串
            result = result toupper(substr(words[i], 1, 1));  # 從每個單詞提取首字母並轉大寫
        }
    }
    print result;
}'
