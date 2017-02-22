#!/bin/bash
# read a file with screen cmd and apply into current screen session

if [ ! -z $BASH_LIB -a -d $BASH_LIB ] ; then
  . $BASH_LIB/lib/readLine.sh
fi

SCREEN_OPT=""
function execScreenCmd () {
	echo -n "screen $SCREEN_OPT -X $@ ... "
 screen $SCREEN_OPT -X $@ \
  && echo OK \
  || echo ERROR
}

# get session arg
while [ ${#@} -gt 0 ] ; do
  case $1 in
    -S|--session) [ ! -z "$2" ] && SCREEN_OPT="-S $2" || quit "-S need session name as argument" ; shift 2 ;;
    *) break ;;
  esac
done

while [ ${#@} -gt 0 ] ; do
	echo "file : '$1'"
	readLine execScreenCmd "$1" \
		|| break
	shift
done

