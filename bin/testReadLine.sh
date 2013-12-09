#!/bin/bash

RL_READ_COMMENT=0
RL_COMMENT="//"
. bashLib/lib/readLine.sh

COUNT=0
function echoLoop() {
	let COUNT++
	echo "line `printf "%03d" $COUNT` : '$@'" 
}

while [ ${#@} -gt 0 ] ; do
	echo "file : '$1'"
	readLine echoLoop "$1" \
		|| break
	shift
done

