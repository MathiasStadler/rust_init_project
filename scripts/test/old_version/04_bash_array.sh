#! /bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2039  # local is non-POSIX

arr=(
"#!/usr/bin/bash -euxo; "
"# # list all option /w status;"
"# grep all with space before the word on; "
"set -o |grep '[[:space:]]on'; "
"CURRENT_PATH=\$(/usr/bin/pwd); "
"echo \$CURRENT_PATH; "
"ls /home && echo \"found\"; "
"# cargo init \$CURRENT_PATH; "
"ls /garbage && echo \"found\"; "
"ls -la \$CURRENT_PATH;"
)

init_command=(
"touch README.md"
"ln -s README.md README"
"cargo init \"\${pwd}\""
"cargo add rustfmt"
"rustup component add rustfmt"
"mkdir examples"
"cp src/main.rs examples/example.rs"
"sed -i -e 's/world/example/g' examples/example.rs"
"rustup  show"
"rustup  check"
"rustup toolchain uninstall stable"
"rustup toolchain install stable"
"rustup update  --force"
"rustup show"
"mkdir tests"

)

# for item in "${arr[@]}"; do
#     echo "$item"
# done 

for item in "${init_command[@]}"; do
    echo "$item"
done 