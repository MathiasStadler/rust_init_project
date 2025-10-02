#!/usr/bin/bash
set -o errtrace
trap "handle_error;exit 1" ERR
declare LOG_LEVEL
if [[ ! -v LOG_LEVEL ]];then echo "LOG_LEVEL is NOT set. Enable log level =>  LOG_LEVEL=info ./<script_name> ";fi
if [[ -v LOG_LEVEL ]];then echo "LOG_LEVEL is set on => $LOG_LEVEL";fi
trap "handle_error;exit 1" ERR
function handle_error(){
local error_code=$?
local error_line=${BASH_LINENO[0]}
local error_command=$BASH_COMMAND
echo "Error occurred on line $error_line: $error_command (exit code: $error_code)"
log "[I] Kill  "
exit 1
}
different=1
function calc_different(){
start=$1
end=$2
postdecpos=0
len_start="${#start}"
len_end="${#end}"
if [ "$len_start" = "$len_end" ];then
log "$LINENO" "[I] OK => Same length $len_start "
else
log "$LINENO" "[I]ERROR Not the same length"
exit 1
fi
log "$LINENO" "[D] $start"
for ((i=0; i<=len_start; i++));do
log "$LINENO" "[D] Iter digit/sign of string $i"
sign_start=${start:i:1}
sign_end=${end:i:1}
if [[ $sign_start == "." ]];then
log "$LINENO" "XXXXXXXXXXXXXXXX [D] point detect"
different=0
else
if [[ $sign_start -eq $sign_end ]];then
log "$LINENO" "[D] Iter = $i Digit of a number equal     $sign_start :: $sign_end"
else
log "$LINENO" "[D] Iter = $i Digit of a number NOT equal $sign_start :: $sign_end => write to different array"
different=0
fi
fi
if [[ $postdecpos -lt 0 ]];then
log "$LINENO" "count the post decimal position $postdecpos"
fi
if [[ different -eq 0 ]];then
log "$LINENO" "[I] enter digit to array start=$sign_start , end=$sign_end"
different_start+=("$sign_start")
different_end+=("$sign_end")
fi
done
r="$(awk '{printf "%.2f\n', "${different_start[@]}" - "${different_end[@]}")' "
echo "$r"
result_start=$(printf "%s" "${different_start[@]}")
result_end=$(printf "%s" "${different_end[@]}")
log "$LINENO" "[D] result start $result_start"
log "$LINENO" "[D] result   end $result_end"
return 0
}
TAG="-"
LOG_FILE="script.log"
function log(){
SCRIPT_NAME="$(/usr/bin/basename "${BASH_SOURCE[0]}")"
echo "script name => $SCRIPT_NAME"
if [ "$HIDE_LOG" ];then
echo -e "[$TAG] $*" >>$LOG_FILE
else
my_space=" "
if [ "${#1}" -eq "1" ];then
echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$my_space$1] - $2"|tee -a $LOG_FILE
elif [ "${#1}" -eq "2" ];then
echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$my_space$1] -$2"|tee -a $LOG_FILE
elif [ "${#1}" -eq "3" ];then
echo "[$(date +"%Y/%m/%d:%H:%M:%S")] [$SCRIPT_NAME:$1] -$2"|tee -a $LOG_FILE
else
echo "not handle"
fi
fi
}
function get_real_time(){
a="${EPOCHREALTIME/[^0-9]/}"
return "$a"
}
function run(){
start="$EPOCHREALTIME"
start="$EPOCHREALTIME"
end="$EPOCHREALTIME"
log "$LINENO" "[I] start"
calc_different "$start" "$end"
log "$LINENO" "[I] end"
return 0
}
function main(){
log "$LINENO" "[I] start $$"
run||exit_handler
}
main
