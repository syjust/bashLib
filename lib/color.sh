#!/bin/bash

# a beautiful script (in my opinion ;) ) using eval to colorize CLI
# USAGE : 
#
# ~> yellow "string" => echo a yellow string WITHOUT "\n"
# ~> bredn "string" => echo a bold and red string with "\n"
# ~> underscoren "string" => echo an underscore string with "\n"
#
# TODO:
# * implement backgrounds
# * implement multiple style


CHAR_ESC="\033"

PREFIX_=""
PREFIX_b="bold"
PREFIX_bl="blink"
PREFIX_u="underscore"
PREFIX_r="reverse"
PREFIX_c="cancel"

STYLE_bold="01"
STYLE_underscore="04"
STYLE_blink="05"
STYLE_reverse="07"
STYLE_cancel="08"

COLOR_black="30"
COLOR_red="31"
COLOR_green="32"
COLOR_yellow="33"
COLOR_blue="34"
COLOR_magenta="35"
COLOR_cyan="36"
COLOR_white="37"

BACKGROUND_black="40"
BACKGROUND_red="41"
BACKGROUND_green="42"
BACKGROUND_yellow="43"
BACKGROUND_blue="44"
BACKGROUND_magenta="45"
BACKGROUND_cyan="46"
BACKGROUND_white="47"

#--------------------------------------------------------------------------------
#  E C H O S    
#--------------------------------------------------------------------------------

function printAndClear() {
	echo -en "$@"
	tput sgr0
}

function printColor() {
	echo -en "$1"
}

export -f printAndClear
export -f printColor

#--------------------------------------------------------------------------------
#  S T Y L E S
#--------------------------------------------------------------------------------

for style_var in ${!STYLE_*} ; do
	func=${style_var##*_}
	eval "style=\$$style_var"
	eval "function ${func}() { printColor \"$CHAR_ESC[${style}m\" ; printAndClear \"\$@\" ; }"
	eval "function ${func}n() { ${func} \"\$@\" ; echo ; }"
	export -f $func
	export -f ${func}n
done

#--------------------------------------------------------------------------------
#  C O L O R S
#--------------------------------------------------------------------------------

for color_var in ${!COLOR_*} ; do
	func=${color_var##*_}
	eval "color=\$$color_var"

	for prefix in ${!PREFIX_*} ; do
		pref=${prefix##*_}
		if [ ! -z "$pref" ] ; then
			eval "style_var=\$$prefix"
			eval "style=\$STYLE_$style_var"
			eval "function ${pref}${func}() { printColor \"$CHAR_ESC[${style};${color}m\" ; printAndClear \"\$@\" ; }"
		else
			eval "function ${pref}${func}() { printColor \"$CHAR_ESC[${color}m\" ; printAndClear \"\$@\" ; }"
		fi

		eval "function ${pref}${func}n() { ${pref}${func} \"\$@\" ; echo ; }"

		export -f ${pref}${func}
		export -f ${pref}${func}n

	done

done

#--------------------------------------------------------------------------------
#  T E E   W I T H O U T   C O L O R
#--------------------------------------------------------------------------------

# TODO: TEST (PREVIOUSLY DONT WORK !!)
# ====================================
function teeWithoutColor() {
	local stdin=""
	if [ -z $1 ] ; then
		#echo "no file given"
		while read stdin ; do
			#echo -n "stdin: " 
			echo "$stdin" | sed 's/[^m]*m//g;s/.$//'
		done
	else
		echo "file given: $1"
		while read stdin ; do
			#echo -n "stdin: " 
			echo "$stdin" | sed 's/[^m]*m//g;s/.$//' | tee -a "$1"
		done
	fi
}
