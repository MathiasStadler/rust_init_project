#!/usr/bin/bash
# shellcheck shell=bash

# FOUND HERE
# https://stackoverflow.com/questions/10218474/how-to-obtain-the-first-letter-in-a-bash-variable#10218528


# 1759144852061815 
# 1759144852062444
variable="1759059933655714";

# four
end="1759086727449999";
start="1759086727441111";
result="$((end - start))"
echo "result => $result"
echo "length of result ${#result}";
echo " r=$(echo "$((end - start)) 10000" | awk '{printf "%.2f\n", $1 / $2}' )"

# five
  end="1759086727499999";
start="1759086727411111";
result="$((end - start))"
echo "result => $result"
echo "length of result ${#result}";
echo " r=$(echo "$((end - start)) 10000" | awk '{printf "%.2f\n", $1 / $2}' )"
echo " r=$(echo "$((end - start)) 10000" | awk '{printf "%f\n", $1 / $2}' )"


# 1759144852061815 
# 1759144852062444
start="1759144852061815";
  end="1759144852062444";

echo "/W AWK r=$(echo "$((end - start)) 10000" | awk '{printf "%.2f\n", $1 / $2}' )"


echo "Length of start $ => ${#start}";
echo "Length of end $ => ${#end}";
# FOUND HERE
# https://linuxsimply.com/bash-scripting-tutorial/loop/for-loop/for-loop-with-variable/
# a=5;
# for ((count=1; count<=a; count++)); do
# echo "Iteration $count"
# done

a=${#start};
different=1 # is false
different_start=()
different_end=()

for ((i=0; i<=a; i++)); do
echo "Iter $i"
sign_start="sign $i ${start:$i:1}";
echo "$sign_start"
sign_end="sign $i ${end:$i:1}";
echo "$sign_end"
# FOUND HERE
# https://linuxsimply.com/bash-scripting-tutorial/conditional-statements/if-else/compare-numbers/
if [[ "$sign_start" = "$sign_end" ]];
 then
    echo " Iter = $i Number1 is equal to number2"
 else
    echo "Iter = $i Number1 is NOT equal to number2"
    set_different(1);
    
fi

if [[ different -eq 0 ]];
then
  different_start+=("$sign_start")
  different_end+=("$sign_end")

fi

done

#exit 0;

first_sign=${variable:0:1}
first_sign=${variable::1}
#two_started_sign=${variable:1:2}

# second sign index started by 0
second_sign=${variable:1:1}

echo "First sign ${first_sign}";
echo "First sign ${second_sign}";
# echo "First sign ${two_started_sign}";

# length of string
echo "Length of variable$ => ${#variable}";
target=${#variable};

#!/bin/bash
for i in {1..10}
do
 echo "Loop spin:" " $i"
done

# from="a" to="m"
# for c in $(eval "echo {$from..$to}"); do echo "$c"; done

# Initialize an empty array for copying
# FOUND HERE
# https://linuxsimply.com/bash-scripting-tutorial/array/array-operations/copy-array/
clone_array=()

for i in $(eval "echo {0..$target}");
do
# add  
echo "$i";
echo " sign ${variable:$i:1}"
clone_array+=("${variable:$i:1}");
done

