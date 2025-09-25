#!/usr/bin/bash
# shellcheck shell=bash

set -o errexit  # Exit script on first error
set -o pipefail # Use the first non-zero exit code (if any) of a \ set of piped command as the exit code of the full set of commands
# set -o         # Show / list the status of shell option
# set -o|grep [[:blank:]]on # Show all enable option
shopt -s extdebug


# FOUND HERE
# https://www.redhat.com/en/blog/bash-error-handling

# ------------Dependencies:......... #
# NO DEPENDENCIES TO ANOTHER SCRIPTS, LIB or PROGRAM - bash as it is :-)

# FOUND HERE trap $LINENO - https://stackoverflow.com/questions/41346907/bash-trap-how-to-get-line-number-of-a-subprocess-with-non-zero-status#41396255

# FOUND HERE  https://www.redhat.com/en/blog/bash-error-handling
set -o errtrace # Enable the err trap, code will get called when an error is detected
# trap 'echo ERROR: There was an error in \(function\) "${FUNCNAME-main context}:$LINENO" , details to follow;exit 1' ERR
trap "handle_error;exit 1"  ERR

# Manual triggering of errors to test the trap function
# cd /tmp/unsense

# ------------- log ---------------- #
# FROM HERE
# https://stackoverflow.com/questions/14008125/shell-script-common-template
# SCRIPT_NAME=$(/usr/bin/basename $BASH_SOURCE)|| exit 100
# FULL_PATH=$(/usr/bin/realpath ${BASH_SOURCE[0]})|| exit 100

# global variable for log
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

# FOUND HERE - https://linuxsimply.com/bash-scripting-tutorial/error-handling-and-debugging/error-handling/trap-err/
function handle_error() {
  # Get information about the error
  local error_code=$?
  local error_line=${BASH_LINENO[0]}
  local error_command=$BASH_COMMAND

  # Log the error details
  echo "Error occurred on line $error_line: $error_command (exit code: $error_code)"

  # Optionally exit the script
  # exit 1

  # used - put on start the script
  # trap handle_error ERR
}


function get_real_time (){
	return  ${EPOCHREALTIME/[^0-9]/};
}

main() {

	# echo $EPOCHSECONDS
	

	log "[D] REALTIME $(get_real_time)";
	log "[D] REALTIME in second $EPOCHSECONDS";
	log "[I]start script";
	log "[I]end script - normally";
	log "[D] ${EPOCHREALTIME/[^0-9]/}";
	log "[D] REALTIME in second $EPOCHSECONDS";
}

main "$@"

# code runner [STRG] + [ALT] + [N]
# shfmt -w 17_bash_array.sh 
