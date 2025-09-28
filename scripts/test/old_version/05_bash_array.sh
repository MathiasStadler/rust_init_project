#ba! /bin/sh
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


# FOUND HERE
#https://stackoverflow.com/questions/11393817/read-lines-from-a-file-into-a-bash-array
# IFS=$'\n' read -d '' -r -a lines < /etc/passwd

command=$(cat <<EOF
pwd
echo "Hello"
EOF
)


echo "START"
echo " \"${command[0]}\" "
echo "END";
# IFS=$'\n' read -d '' -r -a arr < "$command"
# echo "Array => \"$arr\"";
# echo "Array => \"$arr\"";

# echo "${arr[@]}";

# length=${#arr[@]};
#echo "Bash array '\${arr}' has total ${length} element(s) (length)"
# echo "$arr";

#for (( j=0; j<length; j++ ));
#do
#  printf "Current index %d with value %s\n" $j "${arr[$j]}"
#done

# for command in "${arr[@]}"; do
#      ensure echo "$command"
#      ensure "$command"
# done

# sql=$(cat <<EOF
# SELECT foo, bar FROM db
# WHERE foo='baz'
# EOF
# )

# echo "$sql"

# focus/cursor inside windows
# code runner [STRG] + [ALT] + [N]


#1972  text=$command
# 1973  echo $text
# 1974  readarray -d " " -t strarr <<< "$text"
# 1975  for (( n=0; n < ${#strarr[*]}; n++)); do  echo "${strarr[n]}"; done
# 1976  readarray -d "\n" -t strarr <<< "$text"
# 1977  for (( n=0; n < ${#strarr[*]}; n++)); do  echo "${strarr[n]}"; done
 