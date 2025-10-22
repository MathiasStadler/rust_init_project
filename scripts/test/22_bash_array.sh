#!/usr/bin/bash
# shellcheck shell=bash

#maim task code clean up 

# The Set Builtin - found here https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o # Show / list the status of shell option
# set -o|grep [[:blank:]]on # Show all enable option


set -o errtrace pipefail
# short form 
# set -E

# set -o pipefail # Use the first non-zero exit code (if any) of a \ set of piped command as the exit code of the full set of commands

# FOUND HERE - https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s extdebug

# set -o errtrace # Enable the err trap, code will get called when an error is detected

trap "handle_error;exit 1" ERR INT

# Manual triggering of errors to test the trap function
# cd /tmp/unsense

# ------------- log ---------------- #
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

		# Mar 28 14:25:21
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

	#PLEASE REMOVE
	# echo "error handler"

	# Log the error details
	echo "Error occurred on line $error_line: $error_command (exit code: $error_code)"
	exit 1
}

function get_real_time() {
	command=${EPOCHREALTIME/[^0-9]/}
	# $? – The exit status of the last executed command.
	ret=$?
	echo "$command" # output to stdout
	return $ret
}

main() {
	
	# my start="$(get_real_time)";

	start="$(get_real_time)";
	
	
	
	end=$(get_real_time)

	log "${LINENO}" "[I] real time => $(get_real_time)" ;
	log "${LINENO}" "[I] real time start => ${start}" ;
	log "${LINENO}" "[I] real time => ${end}" ;

	#PLEASE REMOVE
	# read -r -a array <<< "${start}"
	# log "${LINENO}" "[D] second => ${array[2]}"


	# first sign of variable
	# FOUND HERE - https://stackoverflow.com/questions/10218474/how-to-obtain-the-first-letter-in-a-bash-variable#10218528
	# 
	# first=${word::1}

	# PLEASE REMOVE
	# echo "$((end - start)) 10000" 
	log "${LINENO}" "start end $start $end"

	during=$(echo "$((end - start)) 10000" | awk '{printf "%.2f\n", $1 / $2}' )
	log "${LINENO}" "[I]end script - normally $during"
}

main "$@"

# code runner [STRG] + [ALT] + [N]
# shfmt -w 17_bash_array.sh
