#!/bin/bash
# this script use imagemagick convert cmd for make blank in png image as tranparent
for i in $@ ; do
	if [ -e "$i" ]  ; then
		if (echo "$i" | egrep -q "\.png$") ; then
			echo -n "converting '$i' ... "
			convert -transparent \#ffffff -fuzz 50%  $i ${i/.png/-t.png} \
				&& echo "ok" \
				|| echo "ERROR"
		else
			echo "'$i' is not a PNG file"
		fi
	else
		echo "'$i' is not a regular file"
	fi
done
