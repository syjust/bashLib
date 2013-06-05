#!/bin/bash

# print clean output for my scripts
# TODO: implement colorization from color.sh

function title () {
	local title="$1" ;
	local size="$2"
	local line=""
	printf -v line "%*s" "$size"
	echo "${line// /-}"
	echo "$title"
	echo "${line// /-}"
}
function bigTitle () {
	local t="$1"
	local title=""
	local halfWord="`echo "${#t}/2" | bc`"
	local firstSize="`echo "39+$halfWord" | bc`"
	local lastSize="`echo "78-$firstSize" | bc`"
	printf -v title "#%*s%*s#" "$firstSize" "$t" "$lastSize"
	title "$title" "80"
}
function subTitle () {
	local t="# $1 #" ;
	title "$t" "${#t}"
}
function splitLine () {
	printf "%-40s : %s\n" "$1" "$2"
}
function splitHalfLine () {
	printf "%-20s : %s\n" "$1" "$2"
}

export -f title
export -f subTitle
export -f bigTitle
export -f splitLine
export -f splitHalfLine
