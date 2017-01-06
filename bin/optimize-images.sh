#!/bin/bash
export jpg_cmd="jpegoptim"
export jpg_opt=" -m90 --strip-all"
export png_cmd="optipng"
export png_opt=" -o5 -strip all"
export OPTIMIZED_FILE_NAME="${0/.sh/.txt}"

PATHES="./"
if [ ! -z "$1" ] ; then
	PATHES="$@"
fi
function quit() {
	echo "$1"
	exit 1
}

for i in {jpg,png}_cmd ; do
	x=`which ${!i}`
	[ -z "$x" ] && quit "'${!i}' ($i) Not found"
	[ -x "$x" ] || quit "'$x' is not executable"
	echo "$i (${!i}) => $x : ok"
done
[ ! -e $OPTIMIZED_FILE_NAME ] && touch $OPTIMIZED_FILE_NAME
[ ! -e $OPTIMIZED_FILE_NAME ] && quit "$OPTIMIZED_FILE_NAME not exits"

function optimize() {
	local type="$1"
	local file="$2"
	if [ -e "$file" ] ; then
		case $type in
			jpg) jpgIze "$file" || pngIze "$file" ;;
			png) pngIze "$file" || jpgIze "$file" ;;
		esac
	else
		echo "'$file' not found" >&2
		return 1
	fi
}

function jpgIze() {
	doIt jpg_cmd jpg_opt "$1"
}

function pngIze() {
	doIt png_cmd png_opt "$1"
}

function doIt() {
	local cmd="${!1}"
	local opt="${!2}"
	local file="$3"
	local f=`egrep "$file:....-..-..:(jpg|png)$" $OPTIMIZED_FILE_NAME`
	if [ ! -z "$f" ] ; then
		echo "$f" | sed 's/^\(.*\):\(....-..-..\):\(jpg\|png\)/file "\1" already optimized at "\2" as "\3" fileType./'
	else
		$cmd $opt "$file" && echo "$file:`date "+%Y-%m-%d"`:${1%%_*}" >> $OPTIMIZED_FILE_NAME
	fi
}

export -f optimize
export -f jpgIze
export -f pngIze
export -f doIt

for path in $PATHES ; do
	find $path -iname "*jpg" -exec bash -c 'optimize "$0" "$1"' jpg {} \;
	find $path -iname "*jpeg" -exec bash -c 'optimize "$0" "$1"' jpg {} \;
	find $path -iname "*png" -exec bash -c 'optimize "$0" "$1"' png {} \;
done
