#!/usr/bin/bash
#shellcheck shell=bash

# set -x

# set -o errexit

# FOUND HERE - https://stackoverflow.com/questions/1835943/how-to-determine-function-name-from-inside-a-function

tt() {
  printf 'function name %s\n' "${FUNCNAME[1]}"
  printf 'size  %s\n' "${#FUNCNAME[@]}"
}

t1() {

    tt
}

t1