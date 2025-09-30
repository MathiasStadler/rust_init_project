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


# shfmt -w var_from_prompt.sh
# shellcheck disable=all
# shellcheck -a var_from_prompt.sh
# shellcheck enable=all
# shellcheck var_from_prompt.sh
echo """