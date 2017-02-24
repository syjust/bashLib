#!/bin/bash
[ ! -z "$BASH_LIB" ] && source $BASH_LIB/lib/color-minproc.sh || exit 1
cnt=0
while read line ; do
  let cnt++
  bcyann "$line"
  read line
  let cnt++
  if [ ! -z "$line" ] ; then
    test $(($cnt % 4)) -eq 0 \
      && byellown "$line" \
      || bgreenn "$line"
  fi
done
