#!/usr/bin/bash
# shellcheck shell=bash

# https://linuxsimply.com/bash-scripting-tutorial/array/array-operations/convert-string-to-array/

# Defining a string
var_string=.02

# Splitting the string into an array
# cars=("$string")

# Output the array and its length
# echo "My array: ${cars[@]}"
# echo "Number of elements in the array: ${#cars[@]}"

# Output the array and its length * instead @
#echo "My array: ${cars[*]}"
#echo "Number of elements in the array: ${#cars[*]}"


foo=$var_string
# echo ${#foo};
# for (( i=0; i<${#foo}; i++ )); do
#   echo "${foo:$i:1}"
# done

echo "${foo:0:1}"

echo "0${foo} ${foo:0:1}";

result=$("0${foo}");

sum=$((result+1))

echo $sum