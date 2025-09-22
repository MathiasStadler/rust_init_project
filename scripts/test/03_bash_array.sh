#! /bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2039  # local is non-POSIX

arr=$(cat <<EOF
"first"
"second"
"third"
"four"
"five"
EOF
)

# echo "$arr";


for item in "${arr[@]}"; do
     echo "$item"
done

# sql=$(cat <<EOF
# SELECT foo, bar FROM db
# WHERE foo='baz'
# EOF
# )

# echo "$sql"