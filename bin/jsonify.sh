#!/bin/bash
function noFile() {
	local f="$@"
	echo "I need a file as argument"
	if [ ! -z "$f" ] ; then
		echo "'$f' is not a valid file"
	fi
	exit 1
}
function jsonify() {
	python -m json.tool "$@"
}
file="$@"
if [ ! -z "$file" ] ; then
	if [ -e "$file" ] ; then
		jsonify "$file"
	else
		noFile $file
	fi
else
	noFile
fi
