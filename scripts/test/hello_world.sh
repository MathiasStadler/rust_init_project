#!/bin/bash

command=$(cat <<EOF
#!/usr/bin/bash -euxo; 
# list all option /w status; 
# grep all with space before the word on; 
set -o |grep '[[:space:]]on'; 
CURRENT_PATH=\$(/usr/bin/pwd); 
echo \$CURRENT_PATH; 
ls /home && echo "found"; 
# cargo init \$CURRENT_PATH; 
ls /garbage && echo "found"; 
ls -la \$CURRENT_PATH;
EOF
)

declare "$command"

hello_world () {

    # convert string in a array
    readarray -d "\n" -t strarr <<< "$command"
   
   for (( n=0; n < ${#strarr[*]}; n++)); do
            echo "Command Nr: => $n"
            echo "RUN COMMEND ${strarr[n]}";
   done;

}

hello_world