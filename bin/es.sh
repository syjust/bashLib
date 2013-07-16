#!/bin/bash
# es.sh : an ElasticSearch bash command line client

PROG="es.sh"
CONFDIR="conf"
CONFFILE="es.conf"

# ------------------------------------------------------------------------------
# VARIABLES
# ------------------------------------------------------------------------------
action=""
index=""
type=""
query=""
url=""
data=""
first_cmd=""

# ------------------------------------------------------------------------------
# READ CONF
# ------------------------------------------------------------------------------

if [ -e "./$CONFDIR/$CONFFILE" ] ; then
	. ./$CONFDIR/$CONFFILE
fi

# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------

function _add() {
	local key="$1"
	local join="$2"
	local value="$3"
	local set=""

	eval "set=\$$key"
	if [ -z "$set" ] ; then
		eval "$key=\"$value\""
	else
		eval "$key=\"$set$join$value\""
	fi
}

function _set() {
	local key="$1"
	local value="$2"
	local set=""

	eval "set=\$$key"
	if [ -z "$set" ] ; then
		if (echo "$value" | grep -qE "^-" > /dev/null 2>&1) ; then
			quit "$value is bad arg for switch $key"
		else
			eval "$key='$value'"
		fi
	else
		quit "$key can't be set twice : ($set != $value)"
	fi
}

function _write() {
	local key="$1"
	local value="$2"
	eval "$key=\"$value\""
}

function usage() {
cat << EOF

$PROG : an ElasticSearch bash command line client
USAGE $PROG [options]

where options are :

  # CRUD / cURL Method's switches
  # -----------------------------
  -U|--UPDATE|-C|--CREATE|-P|--PUT
  -D|--DELETE
  -R|--READ|-G|--GET
  -P|--POST
  
  # URL switches
  # ------------
  -I|--index	INDEX
  -T|--type		TYPE
  -u|--url		URL
  -a|--all
  
  # Commands & Query switches
  # -------------------------
  -c|--command	COMMAND
  -q|--query		QUERY
	-t|--tokenizer	(standard|nGram|edgeNGram)
  -ts|--tokenizer-standard
  -tg|--tokenizer-ngram
  -te|--tokenizer-edge-ngram
  
  # DATA switches
  # -------------
  -d|--data

EOF
}
function quit() {
	echo "$1 !!!" >&2
	usage
	exit 2
}

function run() {
	local complete_url=$url
	[ ! -z "$first_cmd" ] && complete_url="$complete_url/$first_cmd"
	if [ ! -z "$index" ] ; then
		complete_url="$complete_url/$index"
		[ ! -z "$type" ] && complete_url="$complete_url/$type"
	fi

	[ ! -z "$command" ] && complete_url="$complete_url/$command"
	[ ! -z "$query" ] && complete_url="$complete_url?$query"
	[ -z "$action" ] && quit "action is empty"
	[ -z "$url" ] && quit "url is empty"

	if [ -z "$data" ] ; then
		echo "curl -X$action \"$complete_url\"" >&2
		curl -X$action "$complete_url"
	else
		echo "curl -X$action \"$complete_url\" -d \"$data\"" >&2
		curl -X$action "$complete_url" -d "$data"
	fi
	echo
}

# ------------------------------------------------------------------------------
# get options
# ------------------------------------------------------------------------------
while [ ${#@} -ne 0 ] ; do
	case $1 in
		# CRUD / cURL Method's switches
		-U|--UPDATE|-C|--CREATE|-P|--PUT) _set "action" "PUT" ; shift ;;
		-D|--DELETE) _set "action" "DELETE" ; shift ;;
		-R|--READ|-G|--GET) _set "action" "GET" ; shift ;;
		-P|--POST) _set "action" "POST" ; shift ;;
		# URL switches
		-I|--index) _set "index" "$2" ; shift 2 ;;
		-T|--type) _set "type" "$2" ; shift 2 ;;
		-u|--url) _write "url" "$2" ; shift 2 ;;
		-a|--all) _set "first_cmd" "_all" ; shift ;;
		# Commands & Query switches
		-c|--command) _set "command" "$2" ; shift 2 ;;
		-q|--query) _add "query" "&" "$2" ; shift 2 ;;
		-t|--tokenizer) _add "query" "&" "tokenizer=$2" ; shift 2 ;;
		-ts|--tokenizer-standard) _add "query" "&" "tokenizer=standard" ; shift ;;
		-tg|--tokenizer-ngram) _add "query" "&" "tokenizer=nGram" ; shift ;;
		-te|--tokenizer-edge-ngram) _add "query" "&" "tokenizer=edgeNGram" ; shift ;;
		# DATA switches
		-d|--data) _set "data" "$2" ; shift 2 ;;
		# OTHER switches
		*) quit "unrocognized option : '$1'" ;;
	esac
done
# ------------------------------------------------------------------------------
# RUN SCRIPT
# ------------------------------------------------------------------------------

run
