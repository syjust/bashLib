#!/bin/bash

# script that use global_functions and make another getOpt declaration in a script

# --------------------------------------------------------------------------------
# DON'T work at this time because of none visible variable in some used functnions
# --------------------------------------------------------------------------------

# TODO :
# ------
# * rename functions and variables to can loop on and eval for tests and exports
# * export -f `functions`
# * export `variables`

#================================================================================
# VARIABLES
#================================================================================

datef=""
name=""
message="0"
args=""
debug="1"

#================================================================================
# FUNCTIONS
#================================================================================

function isDebug() {
	[ $debug -eq 1 ]
	return $?
}
function debug() {
	isDebug && echo "$@"
}
function title() {
if [ ! -z "$1" ] ; then
	debug "================================================================================"
	debug -e "\t$1"
fi
debug "================================================================================"
}
function quit() {
	ret=0
	title "QUIT CALLED"
	if [ ! -z "$1" ] ; then
		echo -e "$1" | tr "[[:lower:]]" "[[:upper:]]"
		ret=1
		if [ ! -z "$2" ] ; then
			echo "@see error below"
			echo -e "$2"
		fi
		echo
		usage
	fi
	exit $ret
}
function usage() {
if [ ! -z "$1" ] ; then
	echo -e "$1\n" | tr "[[:lower:]]" "[[:upper:]]"
fi
cat << EOF
$0 :
little script for test getOptions function
with text output depends on args and options

Usage : $0 [options] -- args
   where options can be :
      * -h|--help     this message
      * -d|--date f   set 'f' as date format (@see date format)
      * -n|--name n   set 'n' as name
      * -m|--message  output message with date and name (if set)
                      before loop on args
EOF
}

function displayArgs() {
	for i in $args ; do
		echo "* $i"
	done
}
function getOptions() {
	debug "getOptions args given : \"$@\""
	debug "getOptions args count : \"${#@}\""
	count=0;
	debug "start loop"
	debug=0
	while [ ${#@} -ne 0 ] ; do
		val=""
		debug -n "count:$count => arg:\"$1\""
		case $1 in
			-h|--help|-\?) usage "help invoked" ; quit ;;
			-d|--date) datef="$2" ; shift 2 ;;
			-n|--name) name="$2" ; shift 2 ;;
			-m|--message) message=1 ; shift ;;
			-D|--debug) debug=1 ; shift ;;
			--) shift ; args="$@" ; break ;;
			*) args="$args $1" ; shift ;;
		esac
		if [ ! -z "$val" ] ; then
			debug " val:\"$val\"";
		else
			debug
		fi
		isDebug && sleep 0.3
		let count++
	done
	debug -e "end loop\n"
}

#================================================================================
# get options
#================================================================================
title "DEBUG"
debug "args given : \"$@\""
debug "args count : \"${#@}\""
getOptions "$@"

#================================================================================
# TEST OPTIONS
#================================================================================

today=`date $datef 2>&1`
ret=$?
if [ $ret -ne 0 ] ; then
	quit "error on date format ($datef)" "$today"
fi


#================================================================================
# START SCRIPT
#================================================================================


title "START SCRIPT"
if [ $message -eq 1 ] ; then
	echo
	echo "Date du jour : $today."
	echo -n "Bonjour"
	if [ ! -z "$name" ] ; then
		echo -n " $name" | sed -e 's/\([^[:blank:]]\{1,\}\)/\u\1/g'
	fi
	echo ","
	echo "ce petit message prouve que vous avez utilise l'option --message (ou -m)"
	echo "Veuillez trouver ci dessous la liste des arguments ne faisant pas partie des options :"
	displayArgs
	echo
else
	displayArgs
fi

