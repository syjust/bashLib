#!/bin/bash
uid=`id -u`
if [ $uid -ne 0 ] ; then
	echo "root only script, use sudo or go your way !"
	exit 1
fi

quiet=0
user_only=0
while [ ! -z "$1" ] ; do
	case $1 in
		-q|--quiet) quiet=1 ; shift ;;
		-u|--user-only) user_only=1 ; shift ;;
		*) echo "'$1' : arg not recognized (try --quiet or --user-only)" ; exit 1 ;;
	esac
done

for user in $(cut -f1 -d: /etc/passwd); do
	ctab=`crontab -u $user -l 2>&1 | grep -vE "^[[:blank:]]*#"`
	if [ "x$ctab" != "xno crontab for $user" ] ; then
		echo "========================================"
		echo "crontab for user $user :"
		echo "----------------------------------------"
		echo "$ctab"
		echo
	else
		if [ $quiet -eq 0 ] ; then
			echo "-- $ctab"
			echo
		fi
	fi
done

if [ $user_only -eq 0 ] ; then

	for cron_tab in /etc/cron.d/* /etc/crontab ; do
		ctab=`grep -vE "^[[:blank:]]*#" $cron_tab`
		echo "========================================"
		echo "crontab for $cron_tab :"
		echo "----------------------------------------"
		echo "$ctab"
		echo
	done

	for cron_tab in /etc/cron.{hourly,daily,monthly} ; do
		scripts="`ls $cron_tab`"
		if [ ! -z "$scripts" ] ; then
			echo "========================================"
			echo "scripts for crontab $cron_tab :"
			echo "----------------------------------------"
			echo "$scripts"
			echo
		else
			if [ $quiet -eq 0 ] ; then
				echo "-- no scripts for crontab $cron_tab"
				echo
			fi
		fi
	done

fi

if [ $quiet -eq 0 ] ; then
	echo "add '-q' as argument for show only efficient crontabs"
fi
if [ $user_only -eq 0 ] ; then
	echo "add '-u' as argument for show only users crontabs"
fi
