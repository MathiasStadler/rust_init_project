#!/usr/bin/bash
#shellcheck shell=bash

# AWK solution

# FOUND HERE  https://www.redhat.com/en/blog/bash-error-handling
set -o errtrace # Enable the err trap, code will get called when an error is detected
trap "handle_error;exit 1" ERR

#LOG_LEVEL="" <program name>

declare LOG_LEVEL
# FATAL="FATAL"
# ERROR="ERROR"
# WARN="WARN"
# INFO="INFO"
# DEBUG="DEBUG"
TRACE="TRACE"

# Color       #define       Value       RGB
# black     COLOR_BLACK       0     0, 0, 0
# red       COLOR_RED         1     max,0,0
# green     COLOR_GREEN       2     0,max,0
# yellow    COLOR_YELLOW      3     max,max,0
# blue      COLOR_BLUE        4     0,0,max
# magenta   COLOR_MAGENTA     5     max,0,max
# cyan      COLOR_CYAN        6     0,max,max
# white     COLOR_WHITE       7     max,max,max

# FATAL="$(tput setaf 2)INFO(tput sgr0)"
FATAL="$(tput setaf 1)FATAL$(tput sgr0)"
ERROR="$(tput setaf 1)ERROR$(tput sgr0)"
WARN="$(tput setaf 6)WARN$(tput sgr0)"
INFO="$(tput setaf 2)INFO$(tput sgr0)"
DEBUG="$(tput setaf 4)DEBUG$(tput sgr0)"
TRACE="$(tput setaf 0)TRACE$(tput sgr0)"
# not nice but useful

##
red=$(echo -e "\033[31m INFO \033[0m")
echo "$red"

if [[ ! -v LOG_LEVEL ]]; then echo "LOG_LEVEL is NOT set. Enable log level =>  LOG_LEVEL=info ./<script_name> "; fi

if [[ -v LOG_LEVEL ]]; then echo "LOG_LEVEL is set on => $LOG_LEVEL"; fi

# echo "LOG level is set of $LOG_LEVEL";

# calculate the difference from two floating point numbers in plain bash
# Sorry wrong english
# in plain bash function detect different - Since the function diff / awk / bc  doesn't exist in plain bash

# FOUND HERE - https://linuxsimply.com/bash-scripting-tutorial/error-handling-and-debugging/error-handling/trap-err/
function handle_error() {

	# NO function arguments
	# used - put on start the script
	# trap handle_error ERR

	# Get information about the error
	local error_code=$?
	local error_line=${BASH_LINENO[0]}
	local error_command=$BASH_COMMAND

	# Log the error details
	# echo "Error occurred on line $error_line: $error_command (exit code: $error_code)"
	log "${LINENO}" "[E] Error occurred on line $error_line: $error_command (exit code: $error_code)"
	return 1
}

# FOUND HERE
# https://stackoverflow.com/questions/10218474/how-to-obtain-the-first-letter-in-a-bash-variable#10218528

# different found
different=1 # true = 0, false=1

function calc_different() {
	# DESC

	# $1 start first floating number as string
	# $2 end second floating number as string

	# read the method argument
	start=$1
	end=$2

	log "${LINENO}" "$DEBUG" "Method argument start =>${start}"
	log "${LINENO}" "$DEBUG" "Method argument end   =>${end}"

	# post decimal positions https://www.linguee.de/englisch-deutsch/uebersetzung/post+decimal+positions.html
	# postdecpos=0

	# let +=1 https://linuxize.com/post/bash-increment-decrement-variable/
	# let "postdecpos+=1"

	#1: get the length of strings
	len_start="${#start}"
	len_end="${#end}"

	#2: check if have the same length
	if [ "$len_start" = "$len_end" ]; then
		# log "${LINENO}" "$INFO" "OK => Same length $len_start"
		log "${LINENO}" "$INFO" "OK => Same length $len_start - $len_end"
	else
		log "${LINENO}" "$INFO" "ERROR Not the same length"
		exit 1
	fi

	#3 end - start
	different=$(awk -v a="${start}" -v b="${end}" 'BEGIN {printf "%.6f\n", b -a }')
	log "${LINENO}" "$DEBUG" " XXX!!!!! $different"

	return 0
} # end of function

TAG="-"
LOG_FILE="script.log"

# start log
function log() {

	# caller from which function
	local caller="${FUNCNAME[1]}"

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

		my_space=" " #place holder for space
		if [ "${#1}" -eq "1" ]; then
			echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$my_space$1] - [ $2 ] $3" | tee -a $LOG_FILE
		elif [ "${#1}" -eq "2" ]; then
			echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$caller:$my_space$1] - [ $2 ] $3" | tee -a $LOG_FILE
		elif [ "${#1}" -eq "3" ]; then
			echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$caller:$1] - [ $2 ] $3" | tee -a $LOG_FILE
		else
			echo "not handle"
		fi
	fi
}
# end function log

function get_now_real_time() {
	# replace all sign except numbers
	a="${EPOCHREALTIME/[^0-9]/}"
	return "$a"
}

function run() {

	# Unterstützt Unix-Zeitstempel in Sekunden, Millisekunden, Mikrosekunden und Nanosekunden.
	# https://timestamp.toolify.cc/de/
	# 1759231287

	# 1759234385 204 456  second millisecond microsecond

	# https://www.gut-erklaert.de/images/mathematik/zehnerpotenzen-kleine-zahlen-mit-praefix.png
	# milles 10^3 0.001 (mm)
	# micro 10^6 = 0.000 001 (µs)
	# nano 10^9 = 0.000 000 001 (ns)
	# piko 10^12 = 0.000 000 000 001

	#micro-second granularity: $EPOCHREALTIME
	# FOUND HERE https://unix.stackexchange.com/questions/69322/how-to-get-milliseconds-since-unix-epoch
	# echo "$(( ${EPOCHREALTIME//.} / 1000 ))"

	# echo "$(( ${EPOCHREALTIME//.} / 1000 ))"
	# a="${EPOCHREALTIME/[^0-9]/}"

	# without point
	# echo " ${EPOCHREALTIME//.}"
	# with point
	# printf " ${EPOCHREALTIME} \n ${EPOCHREALTIME//.} \n\n"

    # second. millisecond microsecond
	# sec.00000000
	start="$EPOCHREALTIME"
	#test case
	sleep 1
	end="$EPOCHREALTIME"
	calc_different "$start" "$end"

	return 0
}

function check_env() {
	# FOUND HERE - https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script

	# type foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; }
	return 0
}

function main() {

	SCRIPT_NAME="$(/usr/bin/basename "${BASH_SOURCE[0]}")"
	FULL_PATH=$(/usr/bin/realpath "${BASH_SOURCE[0]}")

	# SHOW LOG_LEVEL - https://logging.apache.org/log4j/2.x/javadoc/log4j-api/org/apache/logging/log4j/Level.html#FATAL
	log "${LINENO}" "$FATAL" "A fatal event that will prevent the application from continuing"
	log "${LINENO}" "$ERROR" "An error in the application, possibly recoverable"
	log "${LINENO}" "$WARN" "An event that might possible lead to an error"
	log "${LINENO}" "$INFO" "An event for informational purposes"
	log "${LINENO}" "$DEBUG" "A general debugging event"
	log "${LINENO}" "$TRACE" "A fine-grained debug message, typically capturing the flow through the application"

	log "${LINENO}" "$INFO" "Running =>  $SCRIPT_NAME - PID => $$"
	# PLEASE DON'T activate
	# log "${LINENO}" "[I] Installation folder FULL PATH =>  $("$FULL_PATH")"
	log "${LINENO}" "$ERROR" "Folder of script =>  $(dirname "$FULL_PATH")"
	log "${LINENO}" "$DEBUG" "Execute folder => $(pwd)"
	log "${LINENO}" "$TRACE" "Execute folder => $(pwd)"

	# https://stackoverflow.com/questions/15678796/how-do-i-suppress-shell-script-error-messages
	# cd /nonsense | handle_error

	# bash color
	# FOUND HERE
	# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
	# white="tput setaf 7"
	# red="tput setaf 1"
	# green="tput setaf 2"
	# reset="tput sgr0"
	# echo "${red}red text ${green}green ${white}text${reset}"
	# echo "$($red) red text $($green) green text$(${reset})"

	log "${LINENO}" "$ERROR" "$(tput setaf 1)ERROR$(tput sgr0)"

	run || exit_handler
	log "${LINENO}" "[I] end"
}

main

# TODO [Running] /usr/bin/bash "/home/trapapa/workspace_codium/rust_init_project/scripts/test/02_first_letter_variable.sh"
# TODO [Done] exited with code=1 in 0.016 seconds

# shfmt -w 08_first_letter_variable.sh

# shfmt -ln=bash --write  10_first_letter_variable.sh

# shfmt -ln=bash -w 08_first_letter_variable.sh

## --write
## --simplify
## --minify

# shfmt -ln=bash --write --simplify --minify 09_first_letter_variable.sh

# "shellcheck these script"
# "shellcheck -a 10_first_letter_variable.sh"
