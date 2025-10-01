#!/usr/bin/bash
# shellcheck shell=bash

# set -x

set -o errexit

#LOG_LEVEL="" <program name>

declare LOG_LEVEL

# not nice but useful

if [[ ! -v LOG_LEVEL ]]; then echo "LOG_LEVEL is NOT set. Set like =>  LOG_LEVEL=info ./<script_name> "; fi

if [[ -v LOG_LEVEL ]]; then echo "LOG_LEVEL is set on => $LOG_LEVEL"; fi

# echo "LOG level is set of $LOG_LEVEL";

# calculate the difference from two floating point numbers in plain bash
# Sorry wrong english
# in plain bash function detect different - Since the function diff / awk / bc  doesn't exist in plain bash 

trap "handle_error;exit 1" ERR

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
	echo "Error occurred on line $error_line: $error_command (exit code: $error_code)"

	log "[I] Kill  "
	exit 1
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
start=$1;
end=$2;

#1: get the length of strings
len_start="${#start}";
len_end="${#end}";

#2: check if have the same length
if [ "$len_start" = "$len_end" ]; then
log "${LINENO}" "[I] OK => Same length $len_start "
else
log "${LINENO}" "[I]ERROR Not the same length"
exit 1;
fi

# iter/loop  over both strings
for ((i=0; i<=len_start; i++)); do
log "${LINENO}" "[D] Iter digit/sign of string ${i}"
sign_start=${start:$i:1};
sign_end=${end:$i:1};
# echo "X sign_start $sign_start"
# echo "X sign_end $sign_end"
# FOUND HERE
# https://linuxsimply.com/bash-scripting-tutorial/conditional-statements/if-else/compare-numbers/
if [[ "$sign_start" -eq "$sign_end" ]];
 then
    log "${LINENO}" "[D] Iter = $i Digit of a number equal     $sign_start :: $sign_end"
 else
    log "${LINENO}"  "[D] Iter = $i Digit of a number NOT equal $sign_start :: $sign_end => write to different array"
    different=0 # different set 0 == true
fi

if [[ different -eq 0 ]];
then
  log "${LINENO}" "[I] enter digit to array start=$sign_start , end=$sign_end";
  different_start+=("$sign_start")
  different_end+=("$sign_end")
fi

done

# convert array to string
# FOUND HERE
# https://bashcommands.com/bash-array-to-string
result_start=$(printf "%s" "${different_start[@]}")
result_end=$(printf "%s" "${different_end[@]}")

log "${LINENO}" "[D] result start $result_start"
log "${LINENO}" "[D] result end $result_end"

log "${LINENO}" "[D] result => $(( result_end - result_start )) "

return 0;
}


TAG="-"
LOG_FILE="script.log"

# start log
function log() {

	# arg1 = line number
	# arg2 = message
	# FOUND HERE - https://stackoverflow.com/questions/17804007/how-to-show-line-number-when-executing-bash-script
	
	
	# if [ ${#1} -eq "1" ]; then
	SCRIPT_NAME="$(/usr/bin/basename "${BASH_SOURCE[0]}")"
	
	if [ "$HIDE_LOG" ]; then
		echo -e "[$TAG] $*" >>$LOG_FILE
	else
		# echo "[$(date +"%Y/%m/%d:%H:%M:%S %z")] [$SCRIPT_NAME][$TAG] $*" | tee -a $LOG_FILE
		# PLEASE REMOVE echo "DEBUG => ${#1}";
		my_space=" "; #place holder for space
		if [ "${#1}" -eq "1" ]; then
		echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$my_space$1] - $2" | tee -a $LOG_FILE
		elif [ "${#1}" -eq "2" ]; then
		# one more blank whitespace
		echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$my_space$1] -$2" | tee -a $LOG_FILE
		elif [ "${#1}" -eq "3" ]; then
		# one more blank whitespace
		echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$1] -$2" | tee -a $LOG_FILE
		else
		echo "not handle"
		fi
	fi
}
# end function log

function run () {

# Unterstützt Unix-Zeitstempel in Sekunden, Millisekunden, Mikrosekunden und Nanosekunden.
# https://timestamp.toolify.cc/de/
# 1759231287

#
# 1759144852061
# second
# 1759144852
# milles seconds
# 1759144852061
# nano second
# 1759144852061815

# second
# 1759234385
# milles
# 175923438520
# nano 
# 1759234385204456 


#micro-second granularity: $EPOCHREALTIME
# FOUND HERE https://unix.stackexchange.com/questions/69322/how-to-get-milliseconds-since-unix-epoch
# echo "$(( ${EPOCHREALTIME//.} / 1000 ))"

# echo "$(( ${EPOCHREALTIME//.} / 1000 ))"
# a="${EPOCHREALTIME/[^0-9]/}"

# without point 
# echo " ${EPOCHREALTIME//.}"
# with point
# printf " ${EPOCHREALTIME} \n ${EPOCHREALTIME//.} \n\n"

# test case
start="1759144852061815";
  end="1759144852062444";

# REMOVE
# calc_different()
# calc_different(start, end)

# REMOVE log "I" "start";
log "${LINENO}" "[I] start"
calc_different "$start" "$end";
# REMOVE log "I" "end";
log "${LINENO}" "[I] end"

  return 0;
}


function main(){

log "${LINENO}" "[I] start $$";
run||exit_handler;
}

main;

# TODO [Running] /usr/bin/bash "/home/trapapa/workspace_codium/rust_init_project/scripts/test/02_first_letter_variable.sh"
# TODO [Done] exited with code=1 in 0.016 seconds

