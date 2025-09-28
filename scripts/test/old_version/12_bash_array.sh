#!/bin/bash
# shellcheck shell=bash

set -o errexit  # Exit script on first error
set -o pipefail # Use the first non-zero exit code (if any) of a 
                # set of piped command as the exit code of the 
                # full set of commands
# set -o         # Show / list the status of shell option
# set -o|grep [[:blank:]]on # Show all enable option

# ------------- SCRIPT ------------- #

#!/usr/bin/bash

echo "# script ---------------------->  ${0##*/}"
echo "# script path ----------------->  ${0}    "
echo "# execute path of script run --> $(/usr/bin/pwd)"

if [ $# -eq 0 ]
    then
        echo "No arguments supplied"
    else
	    c=$(($#-1))
        i=1
        while [ $c -ge 0 ];
            do
                echo "$i-th Argument: ${BASH_ARGV[$c]}"
                c=$((c-1))
                i=$((i+1))
            done
fi

echo "# path to me --------------->  ${0}     "
echo "# parent path -------------->  ${0%/*}  "

echo

exit 1;

# commands

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

# code runner [STRG] + [ALT] + [N]