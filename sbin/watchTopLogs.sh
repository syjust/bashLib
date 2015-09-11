#!/bin/bash
# this script cat files described in TOPC_LIST_FILE (one file by line)
# starting at TOPC_IDX_FILE (contain only a numeric value or exit)
# WATCH_INTEVAL tell every which time screen is refreshed (cat next file)
# WATCH_STEP tell how much increase each step for cat next file
# (default is 10 => cat just 1 / 10 file)
# NOTE: TOPC_LISt_FILE is commonly filled by logTop.sh script

WATCH_INTERVAL=1
WATCH_STEP=10
datef="+%Y-%m-%d %H:%M:%S.%N"

TOPC_IDX_FILE=".topc.idx"
TOPC_LIST_FILE=".topc.list"


while [ ! -z "$1" ] ; do
	case $1 in
		-i|--interval) WATCH_INTERVAL=$2 ; shift 2 ;;
		-s|--step) WATCH_STEP=$2 ; shift 2 ;;
		*) echo "$1 : bad args (-i [interval_time] & -s [step_time] are allowed)" ; exit 1 ;;
	esac
done

function test_members() {
	for w in ${!WATCH_*} ; do
		eval "w_=\$$w"
		if ! [[ $w_ =~ ^[0-9\.]+$ ]] ; then
			echo "$w : bad value ($w_)"
			exit 1
		fi
	done
	if [ -e "$TOPC_LIST_FILE" ] ; then
		list_size="`wc -l $TOPC_LIST_FILE | awk '{print $1}'`"
	else
		echo "no TOPC_LIST_FILE"
		exit 1
	fi

	if [ -e "$TOPC_IDX_FILE" ] ; then
		TOPC="`cat $TOPC_IDX_FILE`"
	else
		echo "no TOPC_IDX_FILE"
		TOPC=1
		#echo 1 > $TOPC_IDX_FILE
		#watch -e -n$WATCH_INTERVAL $0 -n # "watch" cmd forgotten for a better "while" solution
	fi
}

function topc() {
	f="`head -n$TOPC $TOPC_LIST_FILE | tail -n1`"
	echo "--  NOW:$TOPC -- `date "$datef"` --"
	echo "-- TOPC:$TOPC -- `date -r $f "$datef"` -- TOP_FILE:$f --"
	if [ -e "$f" ] ; then
		if [ $TOPC -gt $list_size ] ; then
			echo "TOPC grant than list_size ($TOPC > $list_size)"
			cat $f
			#rm $TOPC_IDX_FILE
			exit 1
		else
			cat $f
			TOPC=$(($TOPC+$WATCH_STEP))
			echo $TOPC > $TOPC_IDX_FILE
		fi
	else
		echo "$0 : nothing more (or error)"
		#rm $TOPC_IDX_FILE
		exit 1
	fi
}

function loop_or_exit() {
	if [ -z "$TOPC" ] ; then
		echo "empty TOPC"
		exit 1
	else
		if ! [[ $TOPC =~ ^[0-9]+$ ]] ; then
			echo "TOPC unmatch regex ($TOPC)"
			exit 1
		else
			# @see "watch" forgotten above
			#if [ "$1" == "x-n" ] ; then
			#	topc
			#else
				while [ $TOPC -le $list_size ] ; do
					clear
					topc
					sleep $WATCH_INTERVAL
				done
			#fi
		fi
	fi
}
test_members \
	&& loop_or_exit
