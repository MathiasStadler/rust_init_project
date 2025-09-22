#! /bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2039  # local is non-POSIX

arr=("first" "second" "third" "four" "five")

for item in "${arr[@]}"; do
    echo "$item"
done

# focus/cursor inside windows
# code runner [STRG] + [ALT] + [N]