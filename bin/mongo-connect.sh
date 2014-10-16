#!/bin/bash
# little script to connect to primary mongoDB replicaset
# you can download mongo binaries at http://www.mongodb.org/downloads

prefix="270"
if [ ! -z "$1" ] ; then
	for suffix in $@ ; do
		port="$prefix$suffix"
		ismaster=`bin/mongo --quiet --port $port --eval "rs.isMaster()['ismaster']" 2>/dev/null`
		if [ "$ismaster" == "true" ] ; then
			echo -n "connecting to $port" && sleep 1 && echo -n "." && sleep 1 && echo -n "." && sleep 1 && echo "." 
			bin/mongo --quiet --port $port
			break
		elif [ "$ismaster" == "false" ] ; then
			echo "$port is not master"
		else
			echo "$port is not reachable"
		fi
	done
else
	echo "give me ports as arg like '17' '18' 'etc' (for port ${prefix}17, ${prefix}18, etc)"
fi
