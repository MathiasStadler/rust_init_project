#! /bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2039  # local is non-POSIX

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


arr=$(cat <<EOF
pwd
EOF
)

# echo "$arr";


for command in "${arr[@]}"; do
     ensure "$command"
done

# sql=$(cat <<EOF
# SELECT foo, bar FROM db
# WHERE foo='baz'
# EOF
# )

# echo "$sql"

# focus/cursor inside windows
# code runner [STRG] + [ALT] + [N]