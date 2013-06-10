#!/bin/bash

# this script provide an sql function that use DB_vars previously configured
# you can give another path to DB_CMD if mysql is not in /usr/bin on your system

# default DB Definitions
[ -z "$DB_OPTIONS" ] && DB_OPTIONS="--skip-column-names --batch"
[ -z "$DB_DEBUG" ] && DB_DEBUG="0"
[ -z "$DB_HOST" ] && DB_HOST="localhost"
[ -z "$DB_CMD" ] && DB_CMD="/usr/bin/mysql"

# needed DB Definitions
[ -z "$DB_USER" ] && DB_USER=""
[ -z "$DB_PASS" ] && DB_PASS=""
[ -z "$DB_NAME" ] && DB_NAME=""

# optional DB Definitions
[ ! -z "$DB_PREFIX" ] && DB_PREFIX="${DB_PREFIX}_"

# TESTS
[ ! -x "$DB_CMD" ] && echo "'$DB_CMD' is not executable !!" && exit 2


for db_var in ${!DB_*} ; do
	eval "var=\$$db_var"
	[ -z "$var" ] \
		&& echo "empty var '$db_var'" \
		&& exit 2 \
		|| export $db_var
done

function sql() {
	if [ $DB_DEBUG -eq 1 ] ; then
		echo "$DB_CMD $DB_OPTIONS -e \"${@//#__/$DB_NAME.$DB_PREFIX}\"" >&2
	fi
	$DB_CMD $DB_OPTIONS -h $DB_HOST -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "${@//#__/$DB_NAME.$DB_PREFIX}"
}

export -f sql
