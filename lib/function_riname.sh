#!/bin/bash

# this script is included in my .bashrc to find and rename easily and recursivly 
#files and directories containing ASCII extended or ['-`()] chars

function riname() {
	local file="$1"
	local debug="0"
	local i=0
	local base=""
	local ext=""
	local renamedFile=""

	[ ! -z "$2" ] && debug="$2"

	if [ -z "$file" ]  ; then
		echo "riname: empty file : '$file'" >&2
	else
		if [ -e "$file" -o -d "$file" ] ; then
			renamedFile="`
				echo "$file" \
					| sed "
						s/[[:blank:]()'’_¿-]\{1,\}/_/g;
						s/à/a/g;
						s/À/A/g;
						s/[çç]/c/g;
						s/[ÇÇ]/C/g;
						s/[éèêêë]/e/g;
						s/[ÉÈÊÊË]/E/g;
						s/Ee/E/g;
						s/ee/e/g;
						s/[ôô]/o/g;
						s/[ÔÔ]/O/g;
						s/[ùûû]/u/g;
						s/[ÙÛÛ]/U/g;
						s/[ïïî]/i/g;
						s/[ÏÏÎ]/I/g;
					"
			`"

			if [ "$renamedFile" == "$file" ] ; then
				echo "riname: nothing to do with '$file' -> '$renamedFile'" >&2
			else
				if [ -e "$renamedFile" ] ; then
					ext="${renamedFile##*.}"
					base="${renamedFile/.$ext}"
					while [ -e "$renamedFile" ] ; do
						let i++;
						renamedFile="$base.$i.$ext"
					done
				fi
				if [ $debug -eq 1 ] ; then
					echo "riname (debug): mv -v '$file' -> '$renamedFile'"
				else
					mv -v "$file" "$renamedFile"
				fi
			fi
		else
			echo "riname: file or directory not exists : '$file'" >&2
		fi
	fi
}

function driname() {
	# Debug riname function
	riname "$1" 1
}

function findAndRename() {
	local dir="./"
	local proof="1"
	local debug="0"
	local i=""
	local max=""
	[ ! -z "$2" ] && debug="$2"
	if [ -z "$1" ] ; then
		[ `pwd` == "/" ] \
			&& echo "findAndRename: can't perform search in root directory !!!" >&2 \
			&& exit 2
	else
		dir="$1"
	fi
	if [ -d "$dir" ] ; then
		cd "$dir"
		for i in `find ./ -type d | awk -F/ '{print NF}'` ; do
			[ $i -gt $proof ] && proof=$i
		done
		for max in `seq 1 $proof` ; do
			find ./ -mindepth $max -maxdepth $max -type d -exec bash -c 'riname "$0" "$1"' {} $debug \;
			find ./ -mindepth $max -maxdepth $max -type f -exec bash -c 'riname "$0" "$1"' {} $debug \;
		done
	else
		echo "'$dir' is not a valid directory !!!" >&2
	fi
}

function dfindAndRename() {
	# Debug findAndRename function
	findAndRename "$1" 1
}

export -f riname
export -f driname
export -f findAndRename
export -f dfindAndRename
