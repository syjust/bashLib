#!/bin/bash
[ -z "$BASH_LIB" ] && echo "bashLib path not found" && exit 1
source $BASH_LIB/lib/color.sh

#############
# FUNCTIONS #
#############
quit(){
  bredn -e "$@" | sed "s/\(\"[^\"]*\"\)/$BRED_WHITE_COLOR\\1$BBLACK_RED_COLOR/g;s/\('[^']*'\)/$BRED_WHITE_COLOR\\1$BBLACK_RED_COLOR/g;"
  exit 1
}

#############
# CONSTANTS #
#############
KERNEL="`uname -s`"

###########
# EXPORTS #
###########
export -f quit
export -p KERNEL
