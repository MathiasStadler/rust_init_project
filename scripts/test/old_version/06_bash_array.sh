#ba! /bin/sh
# shellcheck shell=bash

#1972  text=$command
# 1973  echo $text
# 1974  readarray -d " " -t strarr <<< "$text"
# 1975  for (( n=0; n < ${#strarr[*]}; n++)); do  echo "${strarr[n]}"; done
# 1976  readarray -d "\n" -t strarr <<< "$text"
# 1977  for (( n=0; n < ${#strarr[*]}; n++)); do  echo "${strarr[n]}"; done
 


command=$(cat <<EOF
first line
second line
EOF
)

# echo "$command";

#declare -p  "$command";

readarray -d "\n" -t strarr <<< "$command"

# echo "${strarr[@]}"

for (( n=0; n < ${#strarr[*]}; n++)); do
    echo "${strarr[n]}";
    # ${strarr[n]};
done;

# code runner [STRG] + [ALT] + [N]