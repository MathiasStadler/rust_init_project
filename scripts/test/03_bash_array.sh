#! /bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2039  # local is non-POSIX

arr=(
	"first f2 f3"
	"second"
	"third"
	"four"
	"five"
	"pwd"
	"ls"
)

for item in "${arr[@]}"; do
	echo "$item"
done
