#!/usr/bin/bash
# shellcheck shell=bash

# FOUND HERE
# https://stackoverflow.com/questions/10218474/how-to-obtain-the-first-letter-in-a-bash-variable#10218528

variable="1759059933655714";

first_sign=${variable:0:1}
first_sign=${variable::1}
#two_started_sign=${variable:1:2}

# second sign index started by 0
second_sign=${variable:1:1}

echo "First sign ${first_sign}";
echo "First sign ${second_sign}";
# echo "First sign ${two_started_sign}";

# length of string
echo "Length of variable$ => {#variable}";