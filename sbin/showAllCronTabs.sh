#!/bin/bash

for user in $(cut -f1 -d: /etc/passwd); do
	ctab=`crontab -u $user -l 2>&1 | grep -vE "^[[:blank:]]*#"`
	if [ "x$ctab" != "xno crontab for $user" ] ; then
		echo "========================================"
		echo "crontab for user $user :"
		echo "----------------------------------------"
		echo "$ctab"
		echo
	else
		if [ "x$1" != "x-q" ] ; then
			echo "-- $ctab"
		fi
	fi
done

if [ "x$1" != "x-q" ] ; then
	echo
	echo "add '-q' as argument for show only efficient crontab users"
fi
