#!/usr/bin/bash

# FROM HERE
# https://stackoverflow.com/questions/14008125/shell-script-common-template

TAG="foo"
LOG_FILE="example.log"

function log() {
    if [ "$HIDE_LOG" ]; then
        echo -e "[$TAG] $*" >> $LOG_FILE
    else
        echo "[$(date +"%Y/%m/%d:%H:%M:%S %z")] [$TAG] $*" | tee -a $LOG_FILE
    fi
}

log "[I] service start"
log "[D] debug message"

echo "Date => [$(date +"%Y/%m/%d:%H:%M:%S %z")]";