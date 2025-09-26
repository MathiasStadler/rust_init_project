#!/usr/bin/bash
# shellcheck shell=bash


# -E if set, any trap on ERR is inherited by shell functions,
# command substitutions, and commands executed in a subshell environment.
# The ERR trap is NORMALLY NOT inherited in such cases.
set -E
# set -o errexit  # Exit script on first error
set -o pipefail # Use the first non-zero exit code (if any) of a \ set of piped command as the exit code of the full set of commands
# set -o         # Show / list the status of shell option
# set -o|grep [[:blank:]]on # Show all enable option
shopt -s extdebug

# FOUND HERE
# https://www.redhat.com/en/blog/bash-error-handling

# ------------Dependencies:......... #
# NO DEPENDENCIES TO ANOTHER SCRIPTS, LIB or PROGRAM -- bash as it is :-)

# FOUND HERE trap $LINENO - https://stackoverflow.com/questions/41346907/bash-trap-how-to-get-line-number-of-a-subprocess-with-non-zero-status#41396255

# FOUND HERE  https://www.redhat.com/en/blog/bash-error-handling
set -o errtrace # Enable the err trap, code will get called when an error is detected

trap "handle_error;exit 1" ERR

# Manual triggering of errors to test the trap function
# cd /tmp/unsense

# ------------- log ---------------- #
# FROM HERE
# https://stackoverflow.com/questions/14008125/shell-script-common-template
# SCRIPT_NAME=$(/usr/bin/basename $BASH_SOURCE)|| exit 100
# FULL_PATH=$(/usr/bin/realpath ${BASH_SOURCE[0]})|| exit 100

# global variable for log
# TAG="-"

TAG="-"

LOG_FILE="script.log"

# start log
function log() {

	# arg1 = line number
	# arg2 = message

	SCRIPT_NAME="$(/usr/bin/basename "${BASH_SOURCE[0]}" )"
	
	if [ "$HIDE_LOG" ]; then
		echo -e "[$TAG] $*" >>$LOG_FILE
	else
		# TODO dmesg format
		# echo "[$(date +"%Y/%m/%d:%H:%M:%S %z")] [$SCRIPT_NAME][$TAG] $*" | tee -a $LOG_FILE
		echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$1] - $2" | tee -a $LOG_FILE
	fi
}
# end function log

# FOUND HERE - https://linuxsimply.com/bash-scripting-tutorial/error-handling-and-debugging/error-handling/trap-err/
function handle_error() {

	# Get information about the error
	local error_code=$?
	local error_line=${BASH_LINENO[0]}
	local error_command=$BASH_COMMAND

	echo "error handler"

	# Log the error details
	echo "Error occurred on line $error_line: $error_command (exit code: $error_code)"

	# log "[I] Kill  "
	# TODO exit script after first error 
	# sleep 10
	# ps -ef | awk '{print $2}' | grep $$ | xargs kill -9
	# Optionally exit the script
	exit 1
}

function get_real_time() {
	# shortcut, avoid boring copy work
	a="${EPOCHREALTIME/[^0-9]/}"
	return "$a"
}

main() {
	# start="$(get_real_time)"
	log "${LINENO}" "[I]start script - $(get_real_time)"
	# log "${LINENO}" "[D] REALTIME $(get_real_time)"
	# log "${LINENO}" "[D] REALTIME in second $EPOCHSECONDS"

	# log "${LINENO}" "[D] nano ${EPOCHREALTIME/[^0-9]/}"
	# log "${LINENO}" "[D] REALTIME in second $EPOCHSECONDS"
		

	
	

	
	# log "${LINENO}" "[I]end script - normally ${run_time}"

	

	
	
	# time in sec

	#log "[I] real time => ","$(get_real_time)" ;

	# echo "3174 10000" | awk '{printf "%.2f\n", $1 / $2}' => 0.22

	local run_time=$((end - start))
	end=$(get_real_time)

	during=$(echo "$((end - start)) 10000" | awk '{printf "%.2f\n", $1 / $2}' )
	log "${LINENO}" "[I]end script - normally $during"
}

main "$@"

# code runner [STRG] + [ALT] + [N]
# shfmt -w 17_bash_array.sh
