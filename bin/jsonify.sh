#!/bin/bash
# TODO: implement args as JSONpath query
function noFile() {
	local f="$@"
	echo "I need a file as argument"
	if [ ! -z "$f" ] ; then
		echo "'$f' is not a valid file"
	fi
	exit 1
}
function jsonify() {
	local file="$1"
	shift
	python -m json.tool "$file"
}
file="$1"
shift
args="$@"
if [ ! -z "$file" ] ; then
	if [ -e "$file" ] ; then
		# Note args are not implemented
		jsonify "$file" $args
	else
		noFile $file
	fi
else
	noFile
fi
