#!/usr/bin/bash
# shellcheck shell=bash

# ./var_from_prompt.sh
# LOG_LEVEL= ./var_from_prompt.sh
# LOG_LEVEL="" ./var_from_prompt.sh
# LOG_LEVEL="info" ./var_from_prompt.sh
# LOG_LEVEL="debug" ./var_from_prompt.sh

declare LOG_LEVEL
echo "$LOG_LEVEL"
size=${#LOG_LEVEL}

echo "size => $size"

# FOUND HERE
# How to Compare Numbers in Bash With If Statement [2 Methods]
# https://linuxsimply.com/bash-scripting-tutorial/conditional-statements/if-else/compare-numbers/

number1="3";
number2="2";

if [ $number1 -ne $number2 ]; then
    echo "Number1 is not equal to number2"
 else
    echo "Number1 is equal to number2"
fi

if [ $number1 -lt $number2 ]; then
    echo "Number1 is not equal to number2"
 else
    echo "Number1 is equal to number2"
fi



# shfmt -w var_from_prompt.sh
# shellcheck disable=all

echo ""