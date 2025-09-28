#! /bin/bash
# shellcheck shell=bash

# CLEAN UP


 

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

command=$(cat <<EOF
TEST=\$(/usr/bin/pwd)
echo \$TEST
cd /tmp
pwd
cd \$TEST
pwd
EOF
)

readarray -d "\n" -t strarr <<< "$command"

for (( n=0; n < ${#strarr[*]}; n++)); do
    echo "RUN COMMEND ${strarr[n]}";
    # 
    eval "${strarr[n]}";
   
done;

# code runner [STRG] + [ALT] + [N]