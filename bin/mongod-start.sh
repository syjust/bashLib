#!/bin/bash
# little script to start local mongoDB replicaset
# Note : script create directories if necessary
# you can download mongo binaries at http://www.mongodb.org/downloads

replicaSet="rs0"
prefix="270"
if [ ! -z "$1" ] ; then
	port="$1"
	dir="data/$replicaSet-$port"
	[ ! -d "$dir" ] && mkdir -p $dir
	bin/mongod --port $prefix$port --dbpath $dir --replSet $replicaSet --smallfiles --oplogSize 128
else
	echo "give me port as arg like 17 for port ${prefix}17"
fi
