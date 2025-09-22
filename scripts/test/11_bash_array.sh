#! /bin/bash
# shellcheck shell=bash

#!/bin/bash

# ------------- SCRIPT ------------- #

#!/bin/bash

echo
# echo "# arguments called with ---->  ${@}     "
echo "# \$1 ---------------------->  $1       "
echo "# \$2 ---------------------->  $2       "
echo "# path to me --------------->  ${0}     "
echo "# parent path -------------->  ${0%/*}  "
echo "# my name ------------------>  ${0##*/} "
echo

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