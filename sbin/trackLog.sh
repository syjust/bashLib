#!/bin/bash
# TODO: implement a regex generator for split a date in multiple format encountered in /var/log/*log

regex="(25/Aug|Aug 25).*(20:(2[3-9]|[345][0-9])|21:([0-3][0-9]|40)):[0-5][0-9]"
function helpme() {
	echo "$0 : a script for track most connected ip on our /var/log/ directory"
	echo "USAGE : $0 [args] action"
	echo "valid args are :"
	echo " -r|--regex 'the_regex' : a regex for date search (default is \"$regex\" if not given)"
	echo " -h|--help              : print this message and exit successfully"
	echo
	echo "valid actions are : "
	echo "* track                 : grep --color=auto -E \"$regex\" \`find /var/log -type f -name \"*log\" -or -name \"*.log.1\"\` > /tmp/tmp.log"
	echo "* outfiles              : awk -F: '{print \$1}' /tmp/tmp.log | uniq"
	echo "* count                 : grep --color=always -E \"$regex\" /var/log/apache2/*.log | awk '{print \$1}' | sort | uniq -c  | sort -n | less -R"
	echo ""
	echo "Notes :"
	echo "It is preferable to use track before outfiles, etc"
	echo "you have to edit script for change datetime range"

}

[ -z "$1" ] && echo "I need arguments to work... open me to know how I work." && helpme && exit 1

function count_in_apache() {
	[ -z "$regex" ] && echo "function count_in_apache : regex not set" && exit 0
	grep --color=auto -E "$regex" /var/log/apache2/*access.log | awk '{print $1}'
	grep --color=auto -E "$regex" /var/log/apache2/*error.log | sed 's/:\[[^\[]\+\] \[[^\[]\+\] /:/;s/ /_/' | awk '{print $1}'
}

while [ ! -z "$1" ] ; do

	case $1 in

		-r|--regex)
			regex="$2"
			shift
		;;

		-h|--help)
			helpme
			exit 0
		;;

		track)
			# --------------------------------------------------------------------------------
			# track logs for 25 Aug 20:23 - 21:40 range (log & log.1) outputs in /tmp/tmp.log
			# --------------------------------------------------------------------------------
			echo "I grep \"$regex\" from /var/log/*log{,.1} > /tmp/tmp.log"

			grep --color=auto -E "$regex" `find /var/log -type f -name "*log" -or -name "*.log.1"` > /tmp/tmp.log
		;;


		outifles)
			# --------------------------------------------------------------------------------
			# Files outputed are :
			# --------------------------------------------------------------------------------

			[ -e /tmp/tmp.log ] || "/tmp/tmp.log not exits"
			awk -F: '{print $1}' /tmp/tmp.log | uniq
		;;

			# /var/log/auth.log
			#
			# /var/log/daemon.log
			# 
			# #
			# /var/log/apache2/www.esp-errance.access.log
			# /var/log/apache2/academie.access.log
			# /var/log/apache2/faitesduyoga.access.log
			# /var/log/apache2/aidn-formation.error.log
			# /var/log/apache2/www.aidn-formation.access.log
			# /var/log/apache2/other_vhosts_access.log
			# /var/log/apache2/academie.error.log
			# /var/log/apache2/dev.faitesduyoga.aidn.access.log
			# /var/log/apache2/access.log
			# /var/log/apache2/faitesduyoga-ssl.access.log
			# #
			# 
			# /var/log/kern.log



			# --------------------------------------------------------------------------------
			# apache2 are Aug 25 Formated
			# other are 25/Aug Formated (auth, daemon, kern)
			# other logs don't presents problems
			# there is no log.1 files
			# --------------------------------------------------------------------------------

		count)
			# --------------------------------------------------------------------------------
			# Focus on apache2 log files with OutOfTech track cmd
			# --------------------------------------------------------------------------------

			#grep --color=always -E "$regex" /var/log/apache2/*access.log | awk '{print $1}' | sort | uniq -c  | sort -n | less -R
			#grep --color=auto -E "$regex" /var/log/apache2/*error.log | sed 's/:\[[^\[]\+\] \[[^\[]\+\] /:/;s/ /_/' | awk '{print $1}' | sort | uniq -c  | sort -n | less -R
			##44 /var/log/apache2/academie.error.log:[Tue Sep 01 10:09:40 2015] [error] [client 89.84.127.33] PHP Stack trace:
			count_in_apache | sort | uniq -c | sort -n | less -R
		;;

		*)
			echo "$1: NOT A VALID ACTION"
			helpme
		;;

	esac

	shift

done
