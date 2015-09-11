#!/bin/bash
function usage() {
	echo "$0 : a little script that make a 'du -sch | grep G' on directory given as argument"
	echo "USAGE: $0 dir"
	echo "Where dir is a valid directory"
	echo "Note : wildcard (*?.) are not allowed"
}

function quit() {
	echo -e "$1"
	usage
	exit 1
}

[ -z "$1" ] && quit "I need an argument"
[ -d "$1" ] || quit "I need a directory as argument"
du -shc $1/* 2>/dev/null| grep -E "^[0-9\.]+G"
