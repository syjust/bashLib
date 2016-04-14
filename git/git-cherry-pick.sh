#!/bin/bash
# this script take a file with hash to merge line by line as argument
# for each, it perfom a cherry-pick if possible
# if not : display files to merge with git status & use manually git mergetool

# TODO:
# * test we are in a branch
# * test commit is not already done in current branch (with git log)

function hlp() {
echo "HELP"
echo "USAGE: $0 hash-file"
echo "where hash-file is a file containing all git hash to merge in current branch"
echo "this script take a file with hash to merge line by line as argument"
echo "for each, it perfom a cherry-pick if possible"
echo "if not : display files to merge with git status & use manually git mergetool"
}
function tac () {
	awk '1 { last = NR; line[last] = $0; } END { for (i = last; i > 0; i--) { print line[i]; } }'
}
function quit() {
	echo "QUIT : $1"
	exit $2
}
function sedIt() {
	echo "sed in-place $string in $file"
	sleep 2
	local string="$1"
	local file="$2"
	sed -i ".bak" "s/\($string\)/#\1/" $file \
		|| quit "setIt Error" 1
}
function mergeIt() {
	hsh="$1"
	echo "git mergetool $hsh"
	sleep 2
	git status | grep -E "^UU"
	git mergetool \
		&& git commit -a -m "merge from master:$hsh" \
		|| quit "mergeIt Error" 2
}

file="$1"

if [ ! -z "$file" ] ; then
	for i in `grep -vE "^#" $file | tac` ; do
		cmd="git cherry-pick $i"
		echo $cmd
		sleep 1
		$cmd \
			&& sedIt $i $file \
			|| (mergeIt $i && sedIt $i $file)
	done
else
	echo "I need a file with commits hashes as argument"
fi
