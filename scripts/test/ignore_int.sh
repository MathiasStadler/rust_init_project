#!/usr/bin/bash
#shellcheck shell=bash

# FOUND HERE
# https://www.baeldung.com/linux/bash-signal-handling


# trap 'echo SIGINT received and ignored!' INT#
# trap 'SIGINT received and ignored!' INT

trap 'echo "SIGINT received and ignored!"' EXIT
trap -p EXIT


