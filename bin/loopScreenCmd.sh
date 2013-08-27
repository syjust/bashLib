#!/bin/bash
# read a file with screen cmd and apply into current screen session

. bashLib/lib/readline.sh

function execScreenCmd () {
	screen -X $@
}

while [ ${#@} -gt 0 ] ; do
	echo "file : '$1'"
	readLine execScreenCmd "$1" \
		|| break
	shift
done

