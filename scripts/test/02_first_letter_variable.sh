#!/usr/bin/bash
# shellcheck shell=bash

# FOUND HERE
# https://stackoverflow.com/questions/10218474/how-to-obtain-the-first-letter-in-a-bash-variable#10218528


#



# FOUND HERE
# https://linuxsimply.com/bash-scripting-tutorial/loop/for-loop/for-loop-with-variable/
# a=5;
# for ((count=1; count<=a; count++)); do
# echo "Iteration $count"
# done

# a=${#start};

different=1 # true = 0, false=1

# different_start=()
# different_end=()




function calc_different() {

# in plain bash diff / awk / bc not available
# $1 start first floating number as string
# $2 end second floating number as string

start=$1;
end=$2;

# echo "$1"
# echo "$2"
#1: get the length of strings
len_start="${#start}";
len_end="${#end}";

# garbage
# len_start="${#start}";
# len_end="${#end}";
#echo "$len_start"
#echo "$len_end"

#2: check if have the same length
# if [[ $len_start -eq $len_end ]];
if [ "$len_start" = "$len_end" ]; then
log "I" "OK => Same length $len_start "
else
log "I" "ERROR Not the same length"
exit 1;
fi


start=$1
end=$2

# iter/loop  over both strings
for ((i=0; i<=len_start; i++)); do
# echo "Iter $i"
sign_start=${start:$i:1};
sign_end=${end:$i:1};
echo "X sign_start $sign_start"
echo "X sign_end $sign_end"
# FOUND HERE
# https://linuxsimply.com/bash-scripting-tutorial/conditional-statements/if-else/compare-numbers/
if [ "$sign_start" -eq "$sign_end" ];
 then
    log "D" "Iter = $i Digit of a number equal     $sign_start :: $sign_end"
 else
    log "D" "Iter = $i Digit of a number NOT equal $sign_start :: $sign_end => write to different array"
    different=0 # true
    
fi

if [[ different -eq 0 ]];
then
  # log "I" "set different stelle in der zahl";
  different_start+=("$sign_start")
  different_end+=("$sign_end")

fi

done

return 0;
}


TAG="-"
LOG_FILE="script.log"

function log() {
# log - useful for script flow level info/debug

	if [ "$HIDE_LOG" ]; then
		echo -e "[$TAG] $*" >>$LOG_FILE
	else
		echo "[$(date +"%Y/%m/%d:%H:%M:%S %z")] [$TAG] $*" | tee -a $LOG_FILE
	fi

return 0;
}
# end function log


function run () {

start="1759144852061815";
  end="1759144852062444";

# calc_different()
# calc_different(start, end)

log "I" "start";
calc_different "$start" "$end";
log "I" "end";

  return 0;
}


function main(){
run||exit_handler;
}

main;

# TODO [Running] /usr/bin/bash "/home/trapapa/workspace_codium/rust_init_project/scripts/test/02_first_letter_variable.sh"
# TODO [Done] exited with code=1 in 0.016 seconds