#! /bin/bash
# shellcheck shell=bash

set -o pipefail

command=$(cat <<EOF
## #!/usr/bin/bash -euxo; \
&& # list all option /w status; \
&& \
&& # grep all with space before the word on; \
&& set -o |grep '[[:space:]]on' ; \
&& CURRENT_PATH=\$(/usr/bin/pwd); \
&& echo \$CURRENT_PATH ; \
&& ls /home && echo "found" ||echo $? ; \
&& # cargo init \$CURRENT_PATH; \
&& ls /garbage && echo "found" ||echo $?; \
&& ls -la \$CURRENT_PATH;
EOF
)

readarray -d "\n" -t strarr <<< "$command"

allow_return_code () {
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
}

return_code=allow_return_code;



echo $return_code;

# code runner [STRG] + [ALT] + [N]