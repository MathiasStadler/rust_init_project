#! /bin/bash
command=$(cat <<EOF
pwd
echo "Hello"
EOF
)

declare -p command

printf "\necho \$command"
echo "";
echo "$command";
echo "";
echo "set IFS ";
IFS=$'\n'
read -r -d '' -a my_array < "$command"

# declare "$my_array"
#echo "$my_array"
declare "$my_array"