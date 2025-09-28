#!/usr/bin/bash
# shellcheck shell=bash

# set -E
# if set, any trap on ERR is inherited by shell functions,
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
# trap 'echo ERROR: There was an error in \(function\) "${FUNCNAME-main context}:$LINENO" , details to follow;exit 1' ERR
trap "handle_error;exit 1" ERR
# trap "handle_error;exit 1"  EXIT
# trap "handle_error" EXIT
# trap "handle_error" SIGINT # Call cleanup_and_exit function on Ctrl+C
# FOUND HERE - https://linuxsimply.com/bash-scripting-tutorial/error-handling-and-debugging/error-handling/trap-err/

# does not work
# trap 'echo "Error occurred on line $LINENO: $BASH_COMMAND (exit code: $?)" ;  exit 1

# does not work
# trap 'echo "An error occurred: $BASH_COMMAND"; exit 1'

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

# # start log
# function log() {

# 	# FOUND HERE - https://stackoverflow.com/questions/17804007/how-to-show-line-number-when-executing-bash-script
# 	echo "LINENO: ${LINENO}"
#     # echo "BASH_LINENO: ${BASH_LINENO[*]}"

# 	SCRIPT_NAME="$(/usr/bin/basename "${BASH_SOURCE[0]}" )"
# 	# echo "script name => $SCRIPT_NAME";

# 	if [ "$HIDE_LOG" ]; then
# 		echo -e "[$TAG] $*" >>$LOG_FILE
# 	else
# 		# echo "[$(date +"%Y/%m/%d:%H:%M:%S %z")] [$SCRIPT_NAME][$TAG] $*" | tee -a $LOG_FILE
# 		echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME][$TAG] $*" | tee -a $LOG_FILE
# 	fi
# }
# # end function log

# start log
function log() {

	# arg1 = line number
	# arg2 = message

	# FOUND HERE - https://stackoverflow.com/questions/17804007/how-to-show-line-number-when-executing-bash-script
	# TODD clean up
	# echo "LINENO: ${LINENO}"
	# echo "BASH_LINENO: ${BASH_LINENO[*]}"

	SCRIPT_NAME="$(/usr/bin/basename "${BASH_SOURCE[0]}")"
	# echo "script name => $SCRIPT_NAME";

	if [ "$HIDE_LOG" ]; then
		echo -e "[$TAG] $*" >>$LOG_FILE
	else
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

	# sleep 5 && kill $$ &
	# IFS=$' \t\n'  # Reset IFS to default value
	# echo "Hallo"
	# && echo  $$ && echo $!

	log "[I] Kill  "
	# sleep 10
	# ps -ef | awk '{print $2}' | grep $$ | xargs kill -9
	# Optionally exit the script
	exit 1

	# used - put on start the script
	# trap handle_error ERR
}

function get_real_time() {
	echo ${EPOCHREALTIME/[^0-9]/}
}

main() {

	# echo $EPOCHSECONDS
	local start;
	start=$(get_real_time);
	# start=${EPOCHREALTIME/[^0-9]/}
	log "${LINENO}" "[I]start script  ${start}"
	#log "${LINENO}" "[I]start script  $(get_real_time) "
	#log "${LINENO}" "[D] REALTIME $(get_real_time) "
	#log "${LINENO}" "[D] REALTIME in second $EPOCHSECONDS"

	log "${LINENO}" "[D] microsecond 1/1000000 second 	${EPOCHREALTIME/[^0-9]/}"
	log "${LINENO}" "[D] millisecond 1/1000 second 		$((${EPOCHREALTIME/[^0-9]/} /1000))"
	log "${LINENO}" "[D] second 1/1000 second 		$((${EPOCHREALTIME/[^0-9]/} /1000 / 1000))"
	log "${LINENO}" "[D] second                               $EPOCHSECONDS"
	log "${LINENO}" "[I] end script - normally ${start}"

	

	# end=${EPOCHREALTIME/[^0-9]/}
	local end;
	end=$(get_real_time);
	

	local run_time;
	run_time=$((end - start));
	local run_time_second
	run_time_second=$(((end - start)/1000/1000))

	# avoid bc
	echo " comma $(bc -l <<< "scale=2; $((end - start))/1000/1000")"

	echo "x= $((end - start));  if(x<1){\"0\"};  x" | bc -l

	log "${LINENO}" "[I]end script - normally ${run_time}  ${start} ${end}; # ${run_time_second}"

	log "${LINENO}" "HALLO ${end[1]}";

	array="${end}"
	
	log "${LINENO}" "array => ${array[ß]}"

	log "${LINENO}" "array => ${array[4]}"


	
	if [ ${#run_time} -lt 4 ]; then
		echo " < 4";
	fi

	# time_secs="$(${run_time}/1000| bc)";

	# time in sec

	#log "[I] real time => ","$(get_real_time)" ;
}

main "$@"

# code runner [STRG] + [ALT] + [N]
# shfmt -w 18_bash_array.sh
