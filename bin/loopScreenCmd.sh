#!/bin/bash
# read a file with screen cmd and apply into current screen session

if [ ! -z $BASH_LIB -a -d $BASH_LIB ] ; then
  . $BASH_LIB/lib/readLine.sh
fi

function execScreenCmd () {
	screen -X $@
}

while [ ${#@} -gt 0 ] ; do
	echo "file : '$1'"
	readLine execScreenCmd "$1" \
		|| break
	shift
done

