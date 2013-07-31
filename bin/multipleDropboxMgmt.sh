#!/bin/bash

line="--------------------------------------------------------------------------------"

# ================================================================================
# PATH, USAGE & STATIC VARIABLES
# ================================================================================

# PATH
# ----------------------------------------
THIS="`basename $0`"
DBOX_DIR="$HOME/Dropboxes"
DBOXES="`ls $DBOX_DIR`"
DIST_DIR=".dropbox-dist"
DBOX_BIN="dropbox"
COLOR_LIB="bashLib/lib/color.sh"

# ************************************************************
# USAGE_DETAILS
# ************************************************************
USAGE_DETAILS="
$line
$THIS : a Multiple dropbox instances interact Managment
$line

USAGE :
	$THIS action [dboxPath]

	action can be :
		* start
		* stop
		* retstart
		* status
		* login (exec bash in path)
		* install
		* exists

	default dboxPath is any (action is reported on a choosen dropboxe)
	if choose is all (or dboxPath is all) action is recursively reported on a each one by one dropboxe
	dboxPath are in $DBOX_DIR :
	(`echo $DBOXES`)"
#
# ************************************************************

# ================================================================================
# ARGUMENTS
# ================================================================================
																																		
# action
# ----------------------------------------
action="$1"

# dboxPath
# ----------------------------------------
# dboxPath is Dropbox directory path where specific dropbox running (in DBOX_DIR)
# if dboxPath not exists => create it and install it
# if no dboxPath or dboxPath == all : run action on each dropbox in DBOX_DIR

[ -z "$2" ] && dboxPath="any" || dboxPath="$2"


# ================================================================================
# LIBS
# ================================================================================
[ -e "$COLOR_LIB" ] && . $COLOR_LIB || (echo "missing $COLOR_LIB" && exit 2)
# ================================================================================
# FUNCTIONS
# ================================================================================

# Usage, Quit and interact
# ----------------------------------------
function yesOrNo() {
	local resp="N"
	while (true) ; do
		byellow "$1 (y/N) ? "
		read resp
		case $resp in
			y|Y|yes|YES|OUI|oui|o|O) return 0 ;;
			n|N|no|NO|non|NON) return 1 ;;
			*) bredn "'$resp' is not allowed" ;;
		esac
	done
}
function quit() {
	bredn "$line\nERROR : $@\n$line"
	exit 2
}
function usage() {
cat << EOF 
$USAGE_DETAILS
EOF
	if [ ! -z "$1" ] ; then
		quit "$1"
	fi
}

# other functions
# ----------------------------------------

# choose one of existing dropbox in $DBOXES or all
function choose() {
	local action="$1"
	local dboxPath=""
	local ret=0

	select dboxPath in $DBOXES all ; do
		if [ "$dboxPath" == all ] ; then
			ret=1
		else
			run $action $dboxPath
		fi
		break
	done
	return $ret
}

# loop on all dropboxes (DIRS in $DBOXES)
function loop() {
	local action="$1"
	local dboxPath=""
	for dboxPath in ${DBOXES}; do
		run $action $dboxPath
	done
}

# check functions
# ----------------------------------------
function dbox_status() {
	local dboxPath="$1"
	local ret=0
	local pid=`ps aux | awk '$NF ~ '"/$dboxPath.$DIST_DIR.$DBOX_BIN/"' {print $2}'`

	bcyan "Status : "
	if [ -z "$pid" ] ; then
		bcyann "dropbox $HOME is not running"
		ret=1
	else
		bcyann "dropbox $HOME is running with pid $pid"
	fi

	return $ret
}
function dbox_exists() {
	local dboxPath="$1"
	local bin="$HOME/$DIST_DIR/$DBOX_BIN"
	local ret=0
	bmagenta "Exists : "
	if [ -e "$bin" ] ; then
		bmagentan "dropbox '$bin' environment exists"
	else
		bmagentan "dropbox '$bin' environment does not exist"
		if (yesOrNo "do you want install it") ; then
			dbox_install
			ret=$?
		else
			ret=1
		fi
	fi
	return $ret
}
function annonce() {
	bcyann "$annonce $dboxPath ... "
}
function issue() {
	local issue="ERROR"
	[ $1 -eq 0 ] \
		&& issue="OK"
	bcyann "$annonce $dboxPath $issue."
}

# run sub-functions
# ----------------------------------------
function dbox_restart() {
	dbox_stop \
		&& dbox_start
}
function dbox_stop() {
	local ret=1
	local annonce="stopping"
	annonce
	if (dbox_exists $dboxPath) ; then
		if (dbox_status $dboxPath) ; then
			dropbox stop
			ret=$?
		fi
	fi
	issue $ret
	return $ret
}
function dbox_login() {
	cd $HOME
	bash
}
function dbox_install() {
	local ret=0
	local annonce="installing"
	annonce
	if (dbox_exists $dboxPath) ; then
		$ret=1
	else
		dropbox start -i \
		&& dropbox stop
		ret=$?
	fi
	issue $ret
	return $ret
}
function dbox_start() {
	local ret=1
	annonce="starting"
	annonce
	if (dbox_exists $dboxPath) ; then
		if !(dbox_status $dboxPath) ; then
			if [ -e "$HOME/Dropbox" ] ; then
				dropbox start
			else
				bwhiten "$HOME/Dropbox not exists ... auth your '$dboxPath' account with following URL"
				dropbox start \
				&& bwhite "waiting 5s ... " \
				&& sleep 5 \
				&& bwhiten "& start twice" \
				&& dropbox start
			fi
			ret=$?
		fi
	fi
	issue $ret
	return $ret
}


# ================================================================================
# START SCRIPT
# ================================================================================

# run
# ----------------------------------------
# if dboxPath is ok : define local HOME env to lauch DBOX_BIN command
# subFunction star/stop/restart/install/exists are knowing ..
#..following local variables :
#
# * action
# * HOME
# * HOSTNAME
# * dboxPath
#
function run() {
	local action="$1"
	local dboxPath="$2"
	local HOME="$DBOX_DIR/$dboxPath"
	local HOSTNAME="slyWorkServ"
	if [ "$dboxPath" == "any" ] ; then
		choose $action \
			|| loop $action
	else
		if [ ! -d "$HOME" ];then
			if (yesOrNo "$HOME not seems to exist ... create it") ; then
				mkdir -pv $HOME
				for file in .bashrc bin bashLib ; do
					ln -s ../../$file $HOME
				done
			else
				quit "script halt by user"
			fi
		fi
		case $action in

			# the runnable commands
			start)	dbox_start ;;
			stop)		dbox_stop ;;
			restart) dbox_restart ;;
			install) dbox_install ;;
			login)	dbox_login ;;

			# the check commands
			exists)	dbox_exists $dboxPath;;
			status)	dbox_status $dboxPath;;

			# Usage & error
			help|usage) usage "USAGE CALLED" ;;
			*) usage "unrocognized action '$action')" ;;
		esac
	fi
}

if [ -z "$action" ] ; then
	usage "action must be given"
else
	run $action $dboxPath
fi
