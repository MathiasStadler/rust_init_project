#!/usr/bin/bash
#shellcheck shell=bash

# AWK solution

# FOUND HERE  https://www.redhat.com/en/blog/bash-error-handling
set -o errtrace # Enable the err trap, code will get called when an error is detected
trap "handle_error;exit 1" ERR

# FOUND HERE - https://linuxconfig.org/bash-script-error-handling-try-catch-in-bash
exec 2>>error_log.txt

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

FATAL="$(tput setaf 1)FATAL$(tput sgr0)"
ERROR="$(tput setaf 1)ERROR$(tput sgr0)"
WARN="$(tput setaf 6)WARN$(tput sgr0)"
INFO="$(tput setaf 2)INFO$(tput sgr0)"
DEBUG="$(tput setaf 4)DEBUG$(tput sgr0)"
TRACE="$(tput setaf 0)TRACE$(tput sgr0)"

# start log
function log() {

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

	TAG="-"
	LOG_FILE="script.log"

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

# check log level is set
if [[ ! -v LOG_LEVEL ]]; then echo "LOG_LEVEL is NOT set. Enable log level =>  LOG_LEVEL=info ./<script_name> "; fi

# 

# if [[ -v LOG_LEVEL ]]; then echo "LOG_LEVEL is set on => $LOG_LEVEL"; fi
 
if [[ -v LOG_LEVEL ]]; then 
# echo "LOG_LEVEL is set on => $LOG_LEVEL";
log "${LINENO}" "$DEBUG" "Method argument start =>${start}";
fi;



function handle_error() {
	# NO function arguments

	local function_name="${FUNCNAME[0]}"
	local function_caller="${FUNCNAME[1]}"
	log "${LINENO}" "$ERROR" "Call path => $function_caller->$function_name"
	
	# Get information about the error
	local error_code=$?
	local error_line=${BASH_LINENO[0]}
	local error_command=$BASH_COMMAND

	log "${LINENO}" "$ERROR" "=> $$"

	# Log the error details
	# echo "Error occurred on line $error_line: $error_command (exit code: $error_code)"
	log "${LINENO}" "$ERROR" "Error occurred on line $error_line: $error_command (exit code: $error_code)"
	return 1 
}

# different found
different=1 # true = 0, false=1

function calc_different() {
	# description 

	# $1 start first  floating number as string
	# $2 end   second floating number as string

	# read the method argument
	arg_1=$1
	end=$2

	log "${LINENO}" "$DEBUG" "Method argument start =>${arg_1}"
	log "${LINENO}" "$DEBUG" "Method argument end   =>${end}"

	#1: get the length of strings
	len_start="${#arg_1}"
	log "${LINENO}" "$DEBUG" "Length of start timestamp ${len_start}"
	len_end="${#end}"
	log "${LINENO}" "$DEBUG" "Length of end   timestamp ${len_end}"

	# #2: check if have the same length -skip 
	
	#3 end - start
	different=$(awk -v a="${arg_1}" -v b="${end}" 'BEGIN {printf "%.3f\n", b-a }')
	log "${LINENO}" "$DEBUG" "Execute time $different sec"
	log "${LINENO}" "$DEBUG" "$different"
	# echo to stdout, return value of function
	echo "$different";
	return  0
} # end of function calc_different()

function get_now_real_time() {
	# replace all sign except numbers
	a="${EPOCHREALTIME/[^0-9]/}"
	echo "$a" # print to stdout
	# return "$a"
	return 0;
}

function run() {

	#function_name
	local function_name="${FUNCNAME[0]}"
	# caller from which function
	local function_caller="${FUNCNAME[1]}"
	
	log "${LINENO}" "$DEBUG" "Call path => $function_caller->$function_name"
		
	#start of method
	start=$(get_now_real_time);
	log "${LINENO}" "$DEBUG" "Start method ->$start";
		
	wait 1
	#end of method	
	end=$(get_now_real_time);
	log "${LINENO}" "$DEBUG" "End method   ->$end";

	# commend
	a=$("calc_different" "$start" "$end")
	# echo $?
	log "${LINENO}" "$DEBUG" "a => $a"
	
	runtime=123 
	

	echo "runtime $runtime"
	log "${LINENO}" "$DEBUG" "runtime of $runtime" 

	return 0
}


# https://bash.cyberciti.biz/guide/Pass_arguments_into_a_function

function math(){
#	local a=$1
#	local b=$2
	#local sum=$(( a + b))
	return 5
}

function check_env() {
	local function_name="${FUNCNAME[0]}"
	log "${LINENO}" "$ERROR" "$function_name  => $1 <="
	# FOUND HERE - https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
	# FOUND HERE - https://www.delftstack.com/de/howto/linux/error-handling-in-bash/
	type "$1" >/dev/null 2>/dev/null
	ret=$?
	log "${LINENO}" "$DEBUG" "return code $ret"
	case "$ret" in
	0)
	log "${LINENO}" "$DEBUG" "Command available Ok"
  	ret=0;;
	*)
	log "${LINENO}" "$ERROR" "The command => $1 <= is required for this script, but it is not installed "
	log "${LINENO}" "$ERROR" "or cannot be called by the script. - Script abort"
	# log "${LINENO}" "$ERROR" "require foo but it's not installed.  Aborting."
	# !TODO  if it double -> trap EXIT
  	ret=1;;
	esac

	return "$ret"
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
	

	check_env awk|| handle_error
	run || handle_error

	log "${LINENO}" "$INFO" "[I] end"
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
# !NOTE the following comment must be enclosed in quotation marks, otherwise it will be considered an error by shellcheck
# "shellcheck these script"
# "shellcheck -a 10_first_letter_variable.sh"
