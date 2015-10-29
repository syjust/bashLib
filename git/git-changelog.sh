#!/bin/bash
# this script make a $changelog in a git wc for branch actually checkouted
# after that, we perform a diff between each revision in $changelog_folder

# ----------------------------------------
# primary functions
# ----------------------------------------
function quit() {
	echo -e "$@"
	echo "show help with -h for more informations"
	exit 1
}

# ----------------------------------------
# set env path & files
# ----------------------------------------
dirname=`dirname $0`
changelog="$dirname/changelog.txt"
short_changelog_folder="diffFiles"
changelog_folder="$dirname/$short_changelog_folder"

# create $changelog_folder folder if necessary
[ ! -d "$changelog_folder" ] && mkdir $changelog_folder

# ----------------------------------------
# other functions
# ----------------------------------------
function usage() {
	echo
	echo "HELP INVOKED"
	echo ""
	echo "USAGE : $0 [options] [path [paths...]]"
	echo "OPTIONS :"
	echo "-c	make a $changelog file"
	echo "-d	fill $changelog_folder with diff file between each revision"
	echo ""
	echo "DESCRIPTION :"
	echo "this script make a $changelog in a git wc for branch actually checkouted"
	echo "after that, we perform a diff between each revision in $changelog_folder"
	echo "you must be in a git working copy when you launch the command"
	echo
}

function changeLogTitle() {
	echo "####################################################################################################"
	echo "#                                            CHANGELOG                                             #"
	echo "# $0 $@"
	echo "# git log $@ >> $changelog"
	echo "####################################################################################################"
	echo
}

# ----------------------------------------
# get options
# ----------------------------------------
chlog=0
dffile=0
while true ; do
	case $1 in
		-cd|-dc) chlog=1 ; dffile=1 ; shift ;;
		-c) chlog=1 shift ;;
		-d) dffile=1 ; shift ;;
		-h) usage ; exit ;;
		*) break ;;
	esac
done
[ $chlog -eq 0 -a $dffile -eq 0 ] && quit "one of -c or -d have to be used (-c = changelog, -d = diff files)"

# ----------------------------------------
# peform git log in changelog.txt
# ----------------------------------------
if [ $chlog -eq 1 ] ; then
	[ -e "$changelog" ] && quit "$changelog already exists, I can't overwrite it. Remove if you want use -c."
	changeLogTitle > $changelog
	
	git log $@ >> $changelog \
		|| quit "git log failed"
fi

# ----------------------------------------
# extract diff file between each revision
# ----------------------------------------
if [ $dffile -eq 1 ] ; then

	[ ! -e "$changelog" ] && quit "$changelog does not exists... I can't perform a diffFiles Action"

	# init $last_ci & $cnt
	last_ci=""
	cnt=0
	c=00000

	# loop on changelog.txt commits
	for commit in `awk '$1 ~ /^commit/ {print $2}' $changelog | perl -e 'print reverse<>;'` ; do

		if [ -z "$last_ci" ] ; then
			# set $last_ci & continue
			last_ci="$commit"
			continue
		fi

		# fill $c with 0000$cnt
		printf -v c '%05d' $cnt

		diff_file="$changelog_folder/$c-${last_ci:0:8}-${commit:0:8}.diff"
		short_diff_file="$short_changelog_folder/$c-${last_ci:0:8}-${commit:0:8}.diff"

		if [ ! -e "$diff_file" ] ; then
			# perform git diff
			git diff $last_ci $commit $@ > $diff_file \
				|| quit "git diff failed"
			# add $diff_file in $changelog
			#echo "sed -i 's_\(^commit '$commit'\)_\1\ndiffFile: '$short_diff_file'_;' $changelog"
			sed -i 's_\(^commit '$commit'\)_\1\ndiffFile: '$short_diff_file'_;' $changelog \
				|| quit "sed failed"
		fi

		# prepare $last_ci & $cnt for next loop
		last_ci="$commit"
		let cnt++

	done
fi
