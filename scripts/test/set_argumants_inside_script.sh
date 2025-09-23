#!/usr/bin/bash

# FOUND HERE
# https://stackoverflow.com/questions/11065077/the-eval-command-in-bash-and-its-typical-uses#11065196

set -- one two three  # Sets $1 $2 $3
echo "$1";
echo "$2";
echo "$3";
echo "$4"; 

# error_handler

# cmd || error_handler()

_