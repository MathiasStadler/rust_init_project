#!/usr/bin/bash
# shellcheck shell=bash

#maim task code clean up

# The Set Builtin - found here https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o # Show / list the status of shell option
# set -o|grep [[:blank:]]on # Show all enable option

set -o errtrace pipefail pipefail # short form set -E -e

# enable extra BASH flags FOUND HERE - https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s extdebug

# set -o errtrace # Enable the err trap, code will get called when an error is detected
trap "handle_error;exit 1" ERR INT

# Manual triggering of errors to test the trap function
# cd /tmp/unsense

# ------------- log ---------------- #
declare LOG_LEVEL
# handle LOG_LEVEL not SET
if [[ ! -v LOG_LEVEL ]]; then echo "LOG_LEVEL is NOT set. Enable log level =>  LOG_LEVEL=info ./<script_name> "; fi

# echo which LOG:_LEVEL is set
if [[ -v LOG_LEVEL ]]; then echo "LOG_LEVEL is set on => $LOG_LEVEL"; fi

FATAL=(0 "$(tput setaf 1)FATAL$(tput sgr0)")
ERROR=(1 "$(tput setaf 1)ERROR$(tput sgr0)")
WARN=(2 "$(tput setaf 5)WARN$(tput sgr0)")
INFO=(3 "$(tput setaf 2)INFO$(tput sgr0)")
DEBUG=(4 "$(tput setaf 4)DEBUG$(tput sgr0)")
TRACE=(5 "$(tput setaf 0)TRACE$(tput sgr0)")

# LOG_LEVEL_FATAL=0
# LOG_LEVEL_ERROR=1
# LOG_LEVEL_WARN=2
# LOG_LEVEL_INFO=3
# LOG_LEVEL_DEBUG=4
# LOG_LEVEL_TRACE=5


TAG="-"
LOG_FILE="script.log"

# start log
function log() {

	if [ "$2" ]; then

	echo "$2";
	fi

	BLANK=" " #place holder for space

	# get from function call these here - How to determine function name from inside a function
	# https://stackoverflow.com/questions/1835943/how-to-determine-function-name-from-inside-a-function
	local caller="${FUNCNAME[1]}"

	#LOG_LEVEL
	#	log

	# arg1 = line number
	# arg2 = Level
	# arg2 = message
	# FOUND HERE - https://stackoverflow.com/questions/17804007/how-to-show-line-number-when-executing-bash-script

	# FOUND HERE
	# https://stackoverflow.com/questions/14008125/shell-script-common-template
	# SCRIPT_NAME=$(/usr/bin/basename $BASH_SOURCE)|| exit 100
	# FULL_PATH=$(/usr/bin/realpath ${BASH_SOURCE[0]})|| exit 100

	# if [ ${#1} -eq 1 ]; then
	# SCRIPT_NAME=$(/usr/bin/basename "${BASH_SOURCE[@]}") || exit 100

	if [ "$HIDE_LOG" ]; then
		echo -e "[$TAG] $*" >>$LOG_FILE
	else

		
		if [ "${#1}" -eq "1" ]; then
			echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$BLANK$1] - [ $2 ] $3" | tee -a $LOG_FILE
		elif [ "${#1}" -eq "2" ]; then
			echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$caller:$BLANK$1] - [ $2 ] $3" | tee -a $LOG_FILE
		elif [ "${#1}" -eq "3" ]; then
			echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$caller:$BLANK$1] - [ $2 ] $3" | tee -a $LOG_FILE
		else
			echo "not handle"
		fi
	fi
}
# end function log

# ------------- handle error ---------------- #
# FOUND HERE - https://linuxsimply.com/bash-scripting-tutorial/error-handling-and-debugging/error-handling/trap-err/
function handle_error() {

	# Get information about the error
	local error_code=$?
	local error_line=${BASH_LINENO[0]}
	local error_command=$BASH_COMMAND

	# Log error details
	echo "Error occurred on line $error_line: $error_command (exit code: $error_code)"

	#Exit script after error
	exit 1
}

function get_real_time() {
	command=${EPOCHREALTIME/[^0-9]/}
	# $? – The exit status of the last executed command.
	ret=$?
	echo "$command" # output to stdout return to caller
	return $ret
}

main() {

	log "${LINENO}" "${FATAL[1]}"  "Log level=> ${FATAL[1]} is enable "
	log "${LINENO}" "${ERROR[1]}" "Log level=> ${ERROR[1]} is enable "
	log "${LINENO}" "${WARN[1]}"  "Log level=> {WARN[1]} is enable "
	log "${LINENO}" "${INFO[1]}" "Log level=> ${INFO[1]} is enable "
	log "${LINENO}" "${DEBUG[1]}" "Log level=>${DEBUG[1]}is enable "
	log "${LINENO}" "${TRACE[1]}"  "Log level=>${TRACE[1]}is enable "

	start="$(get_real_time)"

	# main doing run

	end=$(get_real_time)

	log "${LINENO}" "${DEBUG[0]}" "real time => $(get_real_time)"

	log "${LINENO}" "${INFO[0]}" "Start end $start $end"

	during=$(echo "$((end - start)) 10000" | awk '{printf "%.2f\n", $1 / $2}')
	log "${LINENO}" "${INFO[0]}" "Finished script - normally (RC=$?,runtime=${during}s)"
}

main "$@"

# code runner [STRG] + [ALT] + [N]
# shfmt -w 24_bash_array.sh
