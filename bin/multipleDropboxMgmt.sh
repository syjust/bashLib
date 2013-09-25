#!/bin/bash

line_dash="--------------------------------------------------------------------------------"
line_asterisk="********************************************************************************"

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
RUN_COLOR="bwhiten"
NICE="19"

# ************************************************************
# USAGE_DETAILS
# ************************************************************
USAGE_DETAILS="
$line_dash
USAGE :
$line_dash
	$THIS action [dboxPath]

	action can be :
		* start
		* stop
		* retstart
		* status
		* login (exec bash in path)
		* update (update $DBOX_BIN versions)
		* install
		* exists

	default dboxPath is any (action is reported on a choosen dropboxe)
	if choose is all (or dboxPath is all) action is recursively reported on a each one by one dropboxe
	dboxPath are in $DBOX_DIR :
	(`echo $DBOXES`)
$line_dash"
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
# dboxPath is Dropbox directory path where specific $DBOX_BIN running (in DBOX_DIR)
# if dboxPath not exists => create it and install it
# if no dboxPath or dboxPath == all : run action on each $DBOX_BIN in DBOX_DIR

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
	local ret=2
	local write="bredn"
	local mess="ERROR"
	if [ ! -z "$2" ] ; then
		ret=$2
		[ $ret -eq 0 ] \
			&& write="bcyann" \
			&& mess="INFO"
	fi
	$write "$line_dash\n$mess : $1\n$line_dash\n"
	exit $ret
}
function usage() {
byellown "$USAGE_DETAILS"
	if [ ! -z "$1" ] ; then
		[ -z "$2" ] \
		&& quit "$1" 0 \
		|| quit "$1" $2
	fi
}

# other functions
# ----------------------------------------

# choose one of existing $DBOX_BIN in $DBOXES or all
function choose() {
	local action="$1"
	local dboxPath=""
	local ret=0

	select dboxPath in $DBOXES all ; do
		RUN_COLOR="bcyann"
		if [ -z "$dboxPath" ] ; then
			bredn "Unvalid choose ! ... another one ?"
		else
			if [ "$dboxPath" == all ] ; then
				ret=1
			else
				RUN_COLOR="bwhiten"
				run $action $dboxPath
			fi
			break
		fi
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
		bredn "$DBOX_BIN $HOME is not running"
		ret=1
	else
		bcyann "$DBOX_BIN $HOME is running with pid $pid"
	fi

	return $ret
}
function dbox_exists() {
	local dboxPath="$1"
	local bin="$HOME/$DIST_DIR/$DBOX_BIN"
	local ret=0
	bmagenta "Exists : "
	if [ -e "$bin" ] ; then
		bmagentan "$DBOX_BIN '$bin' environment exists"
	else
		bmagentan "$DBOX_BIN '$bin' environment does not exist"
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
	local cmd="bredn"
	[ $1 -eq 0 ] \
		&& issue="OK" \
		&& cmd="bcyann"
	$cmd "$annonce $dboxPath $issue."
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
			$DBOX_BIN stop
			ret=$?
		fi
	fi
	issue $ret
	return $ret
}
function testVersion() {
	local from=$1
	local to=$2
	local ret=1
	local annonce="testing the versions"
	annonce
	if (echo "$from" | grep -qE "^[0-9]\.[0-9]\.[0-9]{1,3}$") ; then
		if (echo "$to" | grep -qE "^[0-9]\.[0-9]\.[0-9]{1,3}$") ; then
			eval "`echo "$from" | awk -F. '{print "fmaj="$1";fmin="$2";frev="$3}'`"
			eval "`echo "$to" | awk -F. '{print "tmaj="$1";tmin="$2";trev="$3}'`"
			#if [ $tmaj -gt $fmaj ]
			#	|| ([ $tmaj -eq $fmaj ] && [ $tmin -gt $fmin ])
			#	|| ([ $tmin -eq $fmin ] && [  $trev -gt $frev ])
			#	ret=0
			#else
			#	echo $from is not -lt $to
			#fi
			if [ $tmaj -gt $fmaj ] ; then
				ret=0
			elif [ $tmaj -eq $fmaj ] ; then
				if [ $tmin -gt $fmin ] ; then
					ret=0
				elif [ $tmin -eq $fmin ] ; then
					if [ $trev -gt $frev ] ; then
						ret=0
					fi
				fi
			fi
			[ $ret -ne 0 ] && bredn "$to ! -gt $from"
		else
			bredn "'$to' bad version format"
		fi
	else
		bredn "'$from bad version format"
	fi
	issue $ret
	return $ret
}
function dbox_update() {
	local arch=`arch`
	local system=`uname`
	local ret=1
	local version=""
	local newVersion=""
	local annonce="updating"
	annonce
	if [ $arch == "x86_64" -a "$system" == "Linux" ] ; then
		cd $HOME
		version=`cat $DIST_DIR/VERSION`
		byellow "current version is "
		bblue "$version, "
		byellow "give me version you want to update : "
		read newVersion
		if (testVersion $version $newVersion) ; then
			[ -d tmp ] || mkdir tmp
			[ -d tmp/$DIST_DIR ] && rm tmp/$DIST_DIR
			[ -d tmp ] \
				&& cd tmp \
				&& wget -O - "https://dl-web.dropbox.com/u/17/dropbox-lnx.x86_64-$newVersion.tar.gz" | tar xzf - \
				&& cd $HOME \
				&& rm -rf $DIST_DIR \
				&& mv tmp/$DIST_DIR . \
				&& rm -rf tmp
			ret=$?
		fi
	else
		bredn "unsupported arch '$arch' or system '$system'"
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
	nice -n$NICE $DBOX_BIN start -i \
	&& $DBOX_BIN stop
	ret=$?
	issue $ret
	return $ret
}
function dbox_start() {
	local ret=1
	local annonce="starting"
	annonce
	if (dbox_exists $dboxPath) ; then
		if !(dbox_status $dboxPath) ; then
			if [ -e "$HOME/Dropbox" ] ; then
				nice -n$NICE $DBOX_BIN start
			else
				bwhiten "$HOME/Dropbox not exists ... auth your '$dboxPath' account with following URL"
				$DBOX_BIN start \
				&& bwhite "waiting 5s ... " \
				&& sleep 5 \
				&& bwhiten "& start twice" \
				&& nice -n$NICE $DBOX_BIN start
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
	$RUN_COLOR "\n$line_dash\nStart of run $action $dboxPath\n$line_dash"
	if [ -z "$dboxPath" ] ; then
		usage "empty deboxPath !!!"
	elif [ "$dboxPath" == "any" ] ; then
		choose $action \
			|| loop $action
			RUN_COLOR="bwhiten"
	elif [ "$dboxPath" == "all" ] ; then
			loop $action
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
			install) dbox_exists ;;
			login)	dbox_login ;;
			update)	dbox_update ;;

			# the check commands
			exists)	dbox_exists $dboxPath;;
			status)	dbox_status $dboxPath;;

			# Usage & error
			help|usage) usage "USAGE CALLED" ;;
			*) usage "unrocognized action '$action'" 2;;
		esac
	fi
	$RUN_COLOR "$line_dash\nEnd of run $action $dboxPath\n$line_dash\n"
}

if [ -z "$action" ] ; then
	usage "action must be given" 3
else
	byellown "\n$line_asterisk\n$THIS : a Multiple $DBOX_BIN instances interact Managment\n$line_asterisk"
	run $action $dboxPath
fi
