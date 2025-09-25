#!/usr/bin/bash
# shellcheck shell=bash

set -o errexit  # Exit script on first error
set -o pipefail # Use the first non-zero exit code (if any) of a

# ------------Dependencies:......... #
# NO DEPENDENCIES TO ANOTHER SCRIPTS, LIB or PROGRAM - bash how it is :-)

# FOUND HERE  https://www.redhat.com/en/blog/bash-error-handling
set -o errtrace # Enable the err trap, code will get called when an error is detected
trap 'echo ERROR: There was an error in \(function\) "${FUNCNAME-main context}" , details to follow' ERR


# https://stackoverflow.com/questions/14008125/shell-script-common-template

# FOUND HERE
# FOUND HERE  https://www.redhat.com/en/blog/bash-error-handling
SCRIPT_NAME=$(/usr/bin/basename "${BASH_SOURCE[0]}" )|| exit 100
FULL_PATH=$(/usr/bin/realpath "${BASH_SOURCE[0]}" )|| exit 100

TAG="-"
LOG_FILE="script.log"

function log() {

	if [ "$HIDE_LOG" ]; then
		echo -e "[$TAG] $*" >>$LOG_FILE
	else
		echo "[$(date +"%Y/%m/%d:%H:%M:%S %z")] [$TAG] $*" | tee -a $LOG_FILE
	fi
}
# end function log


function main(){
    log "[I] script start"
    log "[I] script name $SCRIPT_NAME"
    log "[I] script name $FULL_PATH"
    log "[D] debug message"
}