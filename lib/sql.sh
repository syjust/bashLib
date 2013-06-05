#!/bin/bash

# this script provide an sql function that use DB_vars previously configured
# you can give another path to DB_CMD if mysql is not in /usr/bin on your system

#default DB Definitions
[ -z "$DB_USER" ] && DB_USER=""
[ -z "$DB_PASS" ] && DB_PASS=""
[ -z "$DB_NAME" ] && DB_NAME=""
[ -z "$DB_CMD" ] && DB_CMD="/usr/bin/mysql"

[ ! -x "$DB_CMD" ] && echo "'$DB_CMD' is not executable !!" && exit 2


for db_var in ${!DB_*} ; do
	eval "var=\$$db_var"
	[ -z "$var" ] \
		&& echo "empty var '$db_var'" \
		&& exit 2 \
		|| export $db_var
done

function sql() {
	echo "$DB_CMD -e \"$@\"" >&2
	$DB_CMD -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "$@"
}

export -f sql
