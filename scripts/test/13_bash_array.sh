#!/bin/bash
# shellcheck shell=bash

set -o errexit  # Exit script on first error
set -o pipefail # Use the first non-zero exit code (if any) of a 
                # set of piped command as the exit code of the 
                # full set of commands
# set -o         # Show / list the status of shell option
# set -o|grep [[:blank:]]on # Show all enable option

# ------------- log ---------------- #

# FROM HERE
# https://stackoverflow.com/questions/14008125/shell-script-common-template

TAG="-"
LOG_FILE="script.log"

function log() {
    if [ "$HIDE_LOG" ]; then
        echo -e "[$TAG] $*" >> $LOG_FILE
    else
        echo "[$(date +"%Y/%m/%d:%H:%M:%S %z")] [$TAG] $*" | tee -a $LOG_FILE
    fi
}


# ------------- SCRIPT ------------- #

#!/usr/bin/bash

log "[I] script start"
log "[D] debug message"


# echo "# script ---------------------->  ${0##*/}"
# echo "# script path ----------------->  ${0%/*}   "
# echo "# execute path of script run --> $(/usr/bin/pwd)"

log "[I] # script name ->  ${0##*/}"
log "[I] # script path ( /stored on system) ->  ${0%/*}   "
log "[I] # execute path of script -> $(/usr/bin/pwd)"

if [ $# -eq 0 ]
    then
        echo "# No arguments supplied"
    else
	    c=$(($#-1))
        i=1
        while [ $c -ge 0 ];
            do
                #old check to replace
                # echo "# $i-th Command line argument: ${BASH_ARGV[$c]}"
                # https://www.ego4u.de/de/cram-up/vocabulary/numbers/ordinal

                

                if [[ $i -eq 1 ]]; then
                    log "[I] $i-st Command line argument: ${BASH_ARGV[$c]}";
                elif [[ $i -eq 2 ]]; then
                    log "[I] $i-nd Command line argument: ${BASH_ARGV[$c]}";
                elif [[ $i -eq 3 ]]; then
                    log "[I] $i-rd Command line argument: ${BASH_ARGV[$c]}";
                else 
                    log "[I] $i-th Command line argument: ${BASH_ARGV[$c]}";
                fi



                # log "[I] $i-th Command line argument: ${BASH_ARGV[$c]}";
                c=$((c-1))
                i=$((i+1))
            done
fi



command=$(cat <<EOF
## #!/usr/bin/bash -euxo; \
&& # list all option /w status; \
&& \
&& # grep all with space before the word on; \
&& set -o |grep '[[:space:]]on'; \
&& CURRENT_PATH=\$(/usr/bin/pwd); \
&& echo \$CURRENT_PATH; \
&& ls /home && echo "found"; \
&& # cargo init \$CURRENT_PATH; \
&& ls /garbage && echo "found"; \
&& ls -la \$CURRENT_PATH;
EOF
)



execute_list () {
   echo 'start execute_list'

    # convert string in a array
    readarray -d "\n" -t strarr <<< "$command"
   echo "$command";

   for (( n=0; n < ${#strarr[*]}; n++)); do
            echo "Command Nr: => $n"
            echo "RUN COMMEND ${strarr[n]}";
        
        ${strarr[n]};
        local LAST_RETURN_CODE=$?

        if [[ $LAST_RETURN_CODE -eq $1 ]]; then
            return 0
        else
            return $LAST_RETURN_CODE
        fi
    done;
   echo 'end execute_list'
}

return_code=execute_list

echo $return_code

log "[I] script finished !"

# code runner [STRG] + [ALT] + [N]