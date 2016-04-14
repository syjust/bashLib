#!/bin/bash
# filter_branch_files.sh
# remove some files (@see : fileList) of git repo from STARTREV to HEAD

# 108 dots
DOTS="............................................................................................................"
LESS_DOT=0

fileList="$@"

STARTREV=`git log | awk '$1 ~ /commit/ {print $2}' 2>/dev/null | tail -n1 `

function printDate() {
	date "+%Y-%m-%d %H:%M:%S"
}
function startLog() {
	local mess="[`printDate`] `echo -e "$1"`"
	LESS_DOT=${#mess}
	echo -n "$mess"
}
function endLog() {
	local ret=$1
	local endMess="OK"
	[ $ret -ne 0 ] && endMess="ERROR"
	local count=$(( $LESS_DOT + ${#endMess} ))
	printf " %s %s\n" "${DOTS:$count}" "$endMess"
	LESS_DOT=0
	return $ret
}
function endQuit() {
	endLog $1
	exit $?
}
function log() {
	startLog "$1"
	endLog "$2"
}
function quit() {
	startLog "$1"
	endQuit "$2"
}

if [ ! -z "$STARTREV" ] ; then
	if [ ! -z "$fileList" ] ; then
		log "STARTREV:$STARTREV" 0
		log "fileList:$fileList" 0
		for file in $fileList ; do
			if (echo "$file" | grep -qE ".lst$") ; then
				# it is a file list : perform $0 on list inside
				for line in `grep -vE "^[[:blank:]]*($|#)" $file` ; do
					fileInLine=`basename $line`
					while (!($0 $line)) ; do
						startLog "git st"
						git st
						endLog $?
						startLog "git pull"
						git pull
						endLog $?
					done
					startLog "comment $line in $file"
					sed -i 's/^\(.*\)\('"$fileInLine"'\)$/#\1\2/' $file
					endLog $?
					
				done
			else
				log "$file" 0
				git filter-branch --force --index-filter "git update-index --remove $file" $STARTREV..HEAD \
				&& git push --force \
				&& log "$file" $? \
				|| quit "$file" $?
				#[ -e "$file" ] && rm $file
			fi
		done
	else
		quit "empty file list (give file list as argument)" 1
	fi
else
	quit "no start rev in git repo (or not git repo)" 1
fi

exit 0
