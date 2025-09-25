#!/bin/bash

# $0 => is part of the POSIX shell specification, 
# BASH_SOURCE => whereas BASH_SOURCE, as the name suggests, is Bash-specific.

# FROM HERE
# https://stackoverflow.com/questions/35006457/choosing-between-0-and-bash-source

echo "[$0] vs. [${BASH_SOURCE[0]}]"

# multiline comments
_=$(cat <<EOF
$ bash ./foo
[ ./foo ] vs. [./foo]

$ ./foo
[./foo] vs. [./foo]

$ . ./foo
[bash] vs. [./foo]

EOF
)

