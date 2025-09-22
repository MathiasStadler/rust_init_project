#! /bin/bash
# shellcheck shell=bash

# FOUND HERE
# https://github.com/rust-lang/rustup/blob/master/rustup-init.sh
# Run a command that should never fail. If the command fails execution
# will immediately terminate with an error showing the failing
# command.
ensure() {
    if ! "$@"; then
        err "command failed: $*"
        exit 1
    fi
}

need_cmd() {
    if ! check_cmd "$1"; then
        err "need '$1' (command not found)"
        exit 1
    fi
}

check_cmd() {
    command -v "$1" > /dev/null 2>&1
}

# END FROM HERE


t_command=$(cat <<EOF
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

t_command="";


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

# FOUND HERE
# https://stackoverflow.com/questions/2556103/is-it-possible-to-get-the-exit-code-from-a-subshell
# RESULT=`echo Hello; exit 33`; echo ${PIPESTATUS}; echo $RESULT

for (( n=0; n < ${#strarr[*]}; n++)); do
    echo "$n"
    echo "RUN COMMEND ${strarr[n]}";
    # 
    # eval  result="$("${strarr[n]}")";return_value=$?;
    # echo "return value => {$return_value}"
    # echo "ls -la" |xargs eval
    # xargs -p -I {}

done;

# code runner [STRG] + [ALT] + [N]