#!/bin/bash
# read line from file and apply specific command or function on each line read

# read comments ?
# - 0 = no
# - 1 = yes
[ -z "$RL_READ_COMMENT" ] && RL_READ_COMMENT=0 || echo "RL_READ_COMMENT=$RL_READ_COMMENT"

# comment can be pipe separated
[ -z "$RL_COMMENT" ] && RL_COMMENT="#" || echo "RL_COMMENT=$RL_COMMENT"

function testFile() {
	local file="$1"
	[ ! -z "$file" ] && [ -e "$file" ]
}
function readLine() {
	local func="$1"
	local file="$2"
	local ret=1
	if [ -z "$func" ] ; then
		echo "no func given"
	else
		if (testFile "$file") ; then
			if [ $RL_READ_COMMENT -eq 0 ] ; then
				grep -vE "^[[:blank:]]*($RL_COMMENT)" "$file" \
				| while read line ; do
					$func $line
					ret=$(($ret+$?))
				done
			elif [ $RL_READ_COMMENT -eq 1 ] ; then
				while read line ; do
					$func $line
					ret=$(($ret+$?))
				done < "$file"
			else
				echo "'$RL_READ_COMMENT' : bad RL_READ_COMMENT value !!!"
			fi
		fi
	fi
	return $ret
}
export -f testFile
export -f readLine
export RL_READ_COMMENT
export RL_COMMENT
