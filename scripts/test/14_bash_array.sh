#!/usr/bin/bash
# shellcheck shell=bash

set -o errexit  # Exit script on first error
set -o pipefail # Use the first non-zero exit code (if any) of a
# set of piped command as the exit code of the
# full set of commands
# set -o         # Show / list the status of shell option
# set -o|grep [[:blank:]]on # Show all enable option

# ------------- log ---------------- #
# FROM HERE
# https://stackoverflow.com/questions/14008125/shell-script-common-template

TAG="-"
LOG_FILE="script.log"

function log() {
	if [ "$HIDE_LOG" ]; then
		echo -e "[$TAG] $*" >>$LOG_FILE
	else
		echo "[$(date +"%Y/%m/%d:%H:%M:%S %z")] [$TAG] $*" | tee -a $LOG_FILE
	fi
}

# ------------- SCRIPT ------------- #
log "[I] script start"
log "[D] debug message"

log "[I] # script name ->  ${0##*/}"
log "[I] # Executable Path Where the executable is install script path / system location  ->  ${0%/*}   "
log "[I] # execute path of script -> $(/usr/bin/pwd)"

if [ $# -eq 0 ]; then
	echo "# No arguments supplied"
else
	c=$(($# - 1)) # number of arguments
	i=1           # # iteration variable
	while [ $c -ge 0 ]; do
		# https://www.ego4u.de/de/cram-up/vocabulary/numbers/ordinal
		if [[ $i -eq 1 ]]; then
			log "[I] $i-st Command line argument: ${BASH_ARGV[$c]}"
		elif [[ $i -eq 2 ]]; then
			log "[I] $i-nd Command line argument: ${BASH_ARGV[$c]}"
		elif [[ $i -eq 3 ]]; then
			log "[I] $i-rd Command line argument: ${BASH_ARGV[$c]}"
		else
			log "[I] $i-th Command line argument: ${BASH_ARGV[$c]}"
		fi

		c=$((c - 1))
		i=$((i + 1))
	done
fi

# command=$(cat <<EOF
# #!/usr/bin/bash -euxo; \
# # list all option /w status; \
#  \
# # grep all with space before the word on; \
# set -o |grep '[[:space:]]on'; \
# CURRENT_PATH=\$(/usr/bin/pwd); \
# echo \$CURRENT_PATH; \
# ls /home && echo "found"; \
# # cargo init \$CURRENT_PATH; \
# ls /garbage && echo "found"; \
# ls -la \$CURRENT_PATH;
# EOF
# )

command_setup_init=(
	"#!/usr/bin/bash -euxo pipefail"
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

function execute_list() {
	log "[I]start execute_list"

	for ((n = 0; n < ${#command_setup_init[*]}; n++)); do
		#for ((n = 0; n < ${#strarr[*]}; n++)); do

		#for item in "${init_command[@]}"; do
		log "[I] Command Nr: => $n"
		log "[I] RUN COMMEND ${command_setup_init[n]}"

		# $! vs $?

		local LAST_RETURN_CODE=$?

		if [[ $LAST_RETURN_CODE -eq 0 ]]; then
			log "[I] LAST_RETURN_CODE=$LAST_RETURN_CODE"
			return 0
		else
			log "[I] LAST_RETURN_CODE=$LAST_RETURN_CODE"
			return $LAST_RETURN_CODE
		fi
	done
	log "[I] end execute_list"
}
# end execute list

function bash_version() {
	log "[I] bash version"

}
# end of bash_version

function execute_command_stack() {

	for item in "${command_setup_init[@]}"; do
		echo "$item"
	done

}

execute_command_stack

log "[I] script finished !"

# code runner [STRG] + [ALT] + [N]

# shfmt -w 14_bash_array.sh
