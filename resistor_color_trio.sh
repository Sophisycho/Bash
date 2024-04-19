#!/bin/bash

declare -A BAND=(
    [black]=0
    [brown]=1
    [red]=2
    [orange]=3
    [yellow]=4
    [green]=5
    [blue]=6
    [violet]=7
    [grey]=8
    [white]=9
)





trans_num(){
    STRING=''
    if (( ${BAND[$1]} == 0 )) && (( ${BAND[$2]} != 0 )); then
        STRING=${BAND[$2]}
    else
        STRING=${BAND[$1]}${BAND[$2]}
    fi
}

trans_zero(){
    ZERO_NUM=${BAND[$1]}
    ZERO=''
    for (( i=0; i<$ZERO_NUM; i++ )); do
        ZERO+='0'
    done
}

unit(){
    UNIT=''
    FINAL="${STRING}${ZERO}"
    if (( ${#FINAL} > 10 ));then
        UNIT='gigaohms'
        EDIT_FINAL="${FINAL%000000000}"
    elif (( ${#FINAL} > 7 )); then
        UNIT='megaohms'
        EDIT_FINAL="${FINAL%000000}"
    elif (( ${#FINAL} > 4 )); then
        UNIT='kiloohms'
        EDIT_FINAL="${FINAL%000}"
    elif (( ${#FINAL} > 3 )) && [[ ${FINAL:1:1} == 0 ]]; then
        UNIT='kiloohms'
        EDIT_FINAL="${FINAL%000}"
    elif (( STRING == 0 )) && (( ZERO == 0 )); then
        UNIT='ohms'
        EDIT_FINAL="${STRING%0}"
    else
        EDIT_FINAL="${STRING}${ZERO}"
        UNIT='ohms'
    fi
}

check(){
    if [[ -z ${BAND[$1]} ]] || [[ -z ${BAND[$2]}  ]] || [[ -z ${BAND[$3]} ]]; then
        echo "error"
        exit 1
    fi
}


if (( $# >= 3 )); then
    check "$1" "$2" "$3"
    trans_num "$1" "$2"
    trans_zero "$3"
    unit
    echo "${EDIT_FINAL} ${UNIT}"

fi
