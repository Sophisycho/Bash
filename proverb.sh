#!/bin/bash


# 如果只有一個參數 And all for the want of a $1.

# 有兩個參數 For want of a $1 the $2 was lost.


one_para(){
   string="And all for the want of a $1."
   echo "$string"
}


two_para(){
    for (( i=2; i<=$#; i++  )); do
        prev=$((i - 1))
        declare string_$i="For want of a ${!prev} the ${!i} was lost."
        varname="string_$i"
        echo "${!varname}"
    done
}




if (( $# == 1 )); then
    one_para "$1"
elif (( $# >= 2 )); then
    two_para "$@"
    one_para "$1"
else
    echo ""
fi
