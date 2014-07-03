#!/bin/bash

#--------------------------------------------------------------------------------
# CONSTANTS
#--------------------------------------------------------------------------------

CONFFILE="${0/.sh/.conf}"	# readCSVFields.conf where separator is defined

#AWK="/usr/local/bin/gawk"	# the MAC AWK version (gawk if regex filter is enabled)
#AWK="/usr/bin/gawk"		# the AWK version (gawk if regex filter is enabled)
AWK="/usr/bin/awk"			# the AWK version

DEBUG=0						# log level : 0 = no log (used with -d switch option)
							#			  1 = log on stdout output & low verbose
							#             2 = log on stderr output & very verbose

#--------------------------------------------------------------------------------
# variables
#--------------------------------------------------------------------------------
csvFile=""		# the file to read
fields=""		# the fields to display
filter=""		# the value of key to filter lines in CSV file
key=""			# field key number
options=""		# the switches starting with - or -- that change behavior of our script

#--------------------------------------------------------------------------------
# OPTIONS
#--------------------------------------------------------------------------------
alternateSeparator=0
noFirst=0

#--------------------------------------------------------------------------------
# functions
#--------------------------------------------------------------------------------

# default functions (log, getDate, quit, help)
function isDigit() {
	printf "%s" "$1" | grep -qE "^[0-9]+$"
}
function contains() {
	log "contains\n1:$1\n2:$2" 2
	echo -e "$1" | grep -qE "$2"
}
function getDate() {
	date "+%Y-%m-%d %H:%M:%S"
}
function debug() {
	local ret=0
	if [ -z "$1" ] ; then
		[ $DEBUG -gt 0 ]
		ret=$?
	else
		[ $DEBUG -ne 0 -a $DEBUG -ge $1 ]
		ret=$?
	fi
	return $ret
}
function log() {
	if [ $2 -eq 0 ] ; then
		echo -e "[`getDate`] $1"
	else
		if (debug) ; then
			if (debug $2) ; then
				echo -e "[`getDate`] $1" >&$2
			fi
		fi
	fi
	return $2
}
function quit() {
	log "$1\n" 0
	helpMe $2 >&2
	exit $2
}
function helpMe() {
	if [ -z "$1" ] || [ $1 -eq 0 ] ; then
		echo
		echo -e "HELP INVOKED"
		echo -e "This script based on $AWK command, is used to read and filter a CSV file"
		echo -e "arguments given are field list, filter key name, filename"
		echo
	fi
	echo -e "usage : $0 key [options...] field [fields...] filterFieldValue fileName"
	echo -e "\twhere"
	echo -e "\t\"key\"\t\t\tis first field number used as key"
	echo -e "\t\"field\"\t\t\tis second field number to display (note key and field will be displayed)"
	echo -e "\t\"fields\"\t\tthe other fields number that you want display"
	#echo -e "\t\"filterFieldValue\"\tthe value of key that you want filter (can be a regex)"
	echo -e "\t\"filterFieldValue\"\tthe value of key that you want filter"
	echo -e "\t\t\t\t(regex not yet implemented : use gawk instead awk if you need regex implementation)"
	echo -e "\t\"options\"\t\tswitches for change behavior or display or our script"
	echo -e "\t\t\t\t-h|--help\tthis message"
	echo -e "\t\t\t\t-d|--no-debug\tdisable debug log (you can also change DEBUG variable directly into script)"
	echo -e "\t\t\t\t-s|--separator\tchange output default separator by a space"
	echo -e "\t\t\t\t-1|--no-first\tdon't print the key column (first field number given)"
	echo
	if [ -z "$1" ] || [ $1 -eq 0 ] ; then
		exit
	fi
}
function isOption() {
	 printf "%s" "$1" | grep -qE "^--?"
}
function defineOptions() {
	local ret=0
	while [ $# -ne 0 ] ; do
		if (isOption $1) ; then
			log "'$1' seems to be an option... define it" 2
			if [ $# -le 2 ] ; then
				defineOption $1
				quit "$1 is misplaced : options have to be given before filterFieldValue & fileName" 1
			else
				defineOption $1 \
					|| let ret++
			fi
		fi
		shift
	done
	return $ret
}
function isMultipleOption() {
	printf "%s" "$1" | grep -qE "^-[0-9a-zA-Z]{2,}"
}
function defineOption() {
	local option="$1"
	local ret=0
	local count=1
	log "defineOption: $1" 1
	if (isMultipleOption "$1") ; then
		while [ $count -ne ${#1} ] ; do
			defineOption "-${1:$count:1}"
			let count++
		done
	else
		case $option in
			-h|--help) helpMe 0 ;;
			-s|--separator) alternateSeparator=1 ;;
			-1|--no-first) noFirst=1 ;;
			-d|--no-debug) DEBUG=0 ;;
			*) quit "unvalid option given : \"$option\"" 1 ; ret=$? ;;
		esac
	fi
	options="$options $option"
	return $ret
}

# get args 
function defineArgs() {
	local count=0
	while [ $# -ne 0 ] ; do
		if (!(isOption "$1")) ; then
			log "'$1' is not an option" 2
			if [ $# -eq 1 ] ; then			# last arg is the file name
				log "'$1' last arg is the file name" 2
				csvFile=$1
			elif [ $# -eq 2 ] ; then		# penultimate arg is the filter
				log "'$1' penultimate arg is the filter" 2
				filter="$1"
			else							# everything else is field number
				if [ -z "$key" ] ; then	# first field given is key number
					log "'$1' first field given is key number" 2
					key="$1"
					if [ $noFirst -eq 0 ] ; then
						log "'$1' add key to fields" 2
						fields="$1"
					fi
				else
					log "'$1' add to fields" 2
					if [ -z "$fields" ] ; then
						fields="$1"
					else
						fields="$fields $1"
					fi
				fi
			fi
		fi
		shift							# erase arg from args ($@)
		let count++
	done
	[ $count -ne 0 ]
	return $?
}

# test args
function testVariables() {
	local arg=""
	local count="0"
	local field=""
	for arg in CONFFILE AWK key fields filter csvFile ; do
		eval "var=\"\$$arg\""
		log "$arg: $var" 1
		if [ ! -z "$var" ]  ; then
			case $arg in
				filter) : DO NOTHING ;;
				AWK)
					[ -e "$var" -a -x "$var" ] \
						|| quit "$var is not valid AWK version (don't exits or not executable)" 1
					;;
				csvFile|CONFFILE)
					[ -e "$var" -a -r "$var" ] \
						|| quit "$var is not valid $arg (don't exists or is not readable)" 1
					;;
				fields)
					count=`echo "$var" | wc -w`
					if [ "$count" -lt 1 ] ; then
						quit "I need 2 or more fields number to display as argument (only $count given : \"$var\")" 1
					else
						for field in $var ; do
							if (!(isDigit $field)) ; then
								quit "an argument passed as field number is not a digit ($field) !" 1
							fi
						done
					fi
					;;
				key)
					if (!(isDigit "$var")) ; then
						quit "the first argument passed as key field is not a digit ($var) !" 1
					fi
					;;
				*) quit "WTF \"$arg\" ($var) !!!" 1
					;;
			esac
		else
			quit "$arg is empty !!!" 1
		fi
	done
}

function runAWK() {
	. $CONFFILE
	[ -z "$separator" ] && quit "separator is not defined in $CONFFILE !!!" 1
	[ -z "$delimiter" ] && quit "delimiter is not defined in $CONFFILE !!!" 1
	[ $delimiter == '"' ] && delimiter="\\\""
	local printAwkValues=""
	local field=""
	for field in $fields ; do
		if [ -z "$printAwkValues" ] ; then
			printAwkValues="\$$field"
		else
			printAwkValues="$printAwkValues, \$$field"
		fi
	done
	awkCmd="BEGIN { \
		FS=\"$separator\" ; \
		OFS=\"$separator\" ; \
	} \
	\$$key ~ /$filter/  \
	{ \
		gsub (\"$delimiter\", \"\"); \
		print $printAwkValues \
	}"
	log "awk cmd: ${awkCmd//	/}" 2
	$AWK "$awkCmd" $csvFile
}

#--------------------------------------------------------------------------------
# RUN SCRIPT
#--------------------------------------------------------------------------------

debug && echo >&2
defineOptions $@ \
&& defineArgs $@ \
&& testVariables \
&& runAWK \
|| quit "error encountered !!!" $?
