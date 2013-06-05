#!/bin/bash

# first base script to make some tests and log
# TODO :
# * same things in global_functions.sh

function is_null() {
	ret=1
	if [ ${#@} -gt 1 ] ; then
		for i in $@ ; do 
			is_null "$i" && ret=0 && break
		done
	else
		[ -z "$1" ] && ret=0
	fi
	return $ret
}

function error_if_null() {
	error_sentence=$1;shift
	if (is_null $@) ; then 
		echo "ERROR : $error_sentence" >&2
		exit 1
	fi
}

function contains() {
	# $1 is regex $2 ?
	ret=1;value="$1";regex="$2"
	error_if_null "\"contains()\" must have 2 args : value and regex !!" "$value" "$regex"
	(echo -n "$value" | grep -qE "^$regex$") && ret=0
	return $ret
}

function helper() {
	ret=1
	if (contains "$1" "(-h|--help)") ; then
		!(is_null "$2") \
		&& echo -en "HELP REQUIRED :\n$2\n\n" \
		|| echo "NO HELP DEFINE HERE !!" >&2
		ret=0
	fi
	return $ret
}

function debug() {
	if [ ! -z "$DEBUG" ] ; then
		if [ "$DEBUG" -gt 0 ] ; then
			echo "DEBUG : $@"
		fi
	fi
}

function log() {
	log_sentence="$1"
	log_file="$2"
	local_date="$(date '+%Y-%m-%d %H:%M:%S')"
	if (is_null "$log_sentence" "$log_file") ; then 
		echo "ERROR : There Is Not Log File or Log Sentence in \"log\" function !!!" >&2
		exit 1
	else
		debug "I'm logging now : $log_sentence => $log_file"
		dir_log=$(dirname $log_file)
		if [ ! -d "$dir_log" ] ; then mkdir -p $dir_log || debug "can't create dir $dir_log" ; fi
		if [ ! -e "$log_file" ] ; then touch $log_file || debug "can't touch file $log_file" ; fi
		echo -e "$local_date\t$log_sentence" >> $log_file || debug "can't write into $log_file"
	fi
}

function starts_with () {
	start=$1;word=$2;ret=1
	if (is_null "$start" "$word") ; then
		echo "ERROR : \"start_with\" function need's 2 args !!!" >&2
		exit 1
	else
		if (echo -n "$word" | grep -qE "^${start}") ; then
			debug "$word starts with $start ;)"
			ret=0
		else
			debug "$word doesn't starts with $start :("
		fi
	fi
	debug "starts_with ret:$ret"
	return $ret
}
function end_with () {
	end=$1;word=$2;ret=1
	if (is_null "$end" "$word") ; then
		echo "ERROR : \"end_with\" function need's 2 args !!!" >&2
		exit 1
	else
		if (echo -n "$word" | grep -qE "${end}$") ; then
			debug "$word end with $end ;)"
			ret=0
		else
			debug "$word doesn't end with $end :("
		fi
	fi
	debug "end_with ret:$ret"
	return $ret
}

function yes_or_no() {
	echo -n "$1 ? (y/N)"
	read r
	[ "x$r" == "xy" -o "x$r" == "xY" ]
	return $?
}
function Yes_or_no() {
	echo -n "$1 ? (Y/n)"
	read r
	[ "x$r" != "xn" -a "x$r" != "xN" ]
	return $?
}

