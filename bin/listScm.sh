#!/bin/bash
#version=201110212039

#####################
#### DECLARATION ####
#####################

#@ executables
GIT="/usr/local/git/bin/git"
SVN="/usr/bin/svn"
HG="/usr/local/bin/hg"

#@ test_executables

#@ environment
OS=`uname -s`
TEMP=""

#@ functions
EXIT=0

quit() {
   [ ! -z "$1" ] && EXIT="$1" || EXIT=0
   if [ ! -z "$2" ] ; then
      [ "$EXIT" -eq 0 ] \
      && echo -e "\nINFO : $2" \
      || echo -e "\nERROR : $2"
   fi
   [ "$EXIT" -eq 0 ] \
   && usage \
   || usage >&2
   exit $EXIT
}
usage() {
   echo -e "\nusage : $0 [options]"
   echo -e "$0 is a little script based on svn status and awk to grep files added, to add, deleted, to delete or modified in current working copy "
   echo -e "\noptions are : "
   #@ usage
   echo -e "-c|--conflict\t\t"
   echo -e "-s|--svn\t\tuse subversion options and format (default behavior)"
   echo -e "-h|--hg\t\tuse mercurial options and format"
   echo -e "-g|--git\t\tuse git options and format"
   echo -e "-A|--toadd\t\tawk ? svn status"
   echo -e "-D|--todel\t\tawk ! svn status"
   echo -e "-a|--add\t\tawk A svn status"
   echo -e "-d|--del\t\tawk D svn status"
   echo -e "-m|--mod\t\tawk M svn status"
	 echo -e "-z|--aliases\t\tdeclare aliases (NOT WORKING FOR MOMENT)"
   echo -e "-H|--help\t\tthis message"
   echo -e "\nNOTE   : without -AaDdmc options, $0 perform just a status cmd | awk '{print \$NF}'"
   echo -e "\nNOTE 2 : long option doesn't work in mac env"
}

#@ variables
aliases="0"
conflict="0"
git="0"
svn="1"
hg="0"
toadd="0"
todel="0"
add="0"
del="0"
mod="0"


########################
#### SCRIPT OPTIONS ####
########################

#@ get_options
if [ $OS == "Linux" ] ; then
	TEMP=$(getopt -o cgsADadmh --long conflict,git,svn,toadd,todel,add,del,mod,help -- "$@") || quit 1 "bad option in \"$@\""
elif [ $OS == "Darwin" ] ; then
	TEMP=`getopt HcgsADadmh: $*` || quit 1 "bad option in \"$@\"" #this is a bsd mac os quick fix for getopt
fi
[ -z "$TEMP" ] && quit 1 "unrocognized OS Type ($OS) - Only Linux & Darwin are supported"
eval set -- "$TEMP"

while true ; do
   case $1 in
      #@ define_variables
      -c|--conflict) conflict="1" ; shift ;;
      -g|--git) git="1" ; svn=0 ; shift ;;
      -s|--svn) svn="1" ; shift ;;
      -h|--hg) hg="1" ; svn=0 ; shift ;;
			-A|--toadd) toadd="1" ; shift ;;
      -D|--todel) todel="1" ; shift ;;
      -a|--add) add="1" ; shift ;;
      -d|--del) del="1" ; shift ;;
      -m|--mod) mod="1" ; shift ;;
      -H|--help) quit 0 "help is invoked" ;;
			-z|--aliases) aliases="1" ; shift ;;
      --) shift ; break;;
      *) quit 102 "\"$1\" is a bad option" ;;
   esac
done

if [ "$git" != "0" ] ; then
	toaddexp='\?\?'
	delexp='D'
	if [ -x "$GIT" ] ; then
	   version=`$GIT --version | awk '{print $3}'`
	   [ $version == '1.7.11' ] \
	   && CMD="$GIT status -s" \
	   || quit 3 "$GIT version $version is not compatible with this script"
   else
   		quit 4 "$GIT is not executable"
   fi
fi
if [ "$hg" != "0" ] ; then
	toaddexp='\?'
	delexp='R'
	if [ -x "$HG" ] ; then
	   version=`$HG --version --quiet | awk '{print $NF}' | awk -F+ '{print $1}'`
	   [ $version == '2.2.2' ] \
	   && CMD="$HG st" \
	   || quit 3 "$HG version $version is not compatible with this script"
   else
   		quit 4 "$HG is not executable"
   fi
fi
if [ "$svn" != "0" ] ; then
	toaddexp='\?'
	delexp='D'
	if [ -x "$SVN" ] ; then
	   version=`$SVN --version --quiet`
	   [ $version == '1.6.17' ] \
	   && CMD="$SVN st" \
	   || quit 3 "$SVN version $version is not compatible with this script"
   else
   		quit 4 "$SVN is not executable"
   fi
fi

#@ test_options
[ $git -eq $svn -a $hg -eq $svn ] && quit 2 "--svn and --git are not compatible"

#@ get_arguments
: Where you get_arguments after last switche --  

#@ declare_functions
: where functions of script and last test section  are

#@ test_arguments
: Where you test all options of get_options and get_arguments section 

######################
#### START SCRIPT ####
######################

#@ start_script
if [ "$aliases" != "0" ] ; then
	for val in svn hg git ; do
		v=${val:0:1}
		alias modified${val}="$0 -${v}m"
		alias deleted${val}="$0 -${v}d"
		alias added${val}="$0 -${v}a"
		alias toadd${val}="$0 -${v}A"
		alias toadd${val}bak="$0 -${v}A | grep -E 'bak$'"
		alias todel${val}="$0 -${v}D"
	done
fi
if [ "$conflict" != "0" ] ; then
	AWKEXP='$1 ~ /C/ {print $NF}'
fi
if [ "$toadd" != "0" ] ; then
	AWKEXP='$1 ~ /'"$toaddexp"'/ {print $NF}'
fi
if [ "$todel" != "0" ] ; then
	AWKEXP='$1 ~ /\!/ {print $NF}'
fi
if [ "$add" != "0" ] ; then
	AWKEXP='$1 ~ /A/ {print $NF}'
fi
if [ "$del" != "0" ] ; then
	AWKEXP='$1 ~ /'"$delexp"'/ {print $NF}'
fi
if [ "$mod" != "0" ] ; then
	AWKEXP='$1 ~ /M/ {print $NF}'
fi

if [ ! -z "$AWKEXP" ] ; then
	$CMD | awk "$AWKEXP"
else
	$CMD | awk '{print $NF}'
fi
