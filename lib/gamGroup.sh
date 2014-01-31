#!/bin/bash

[ -z "$GAM_GROUP" ] && GAM_GROUP=""
[ -z "$GAM_PY" ] && GAM_PY="python/gam/gam.py"

for gamvar in ${!GAM_*} ; do
	eval "var=\$$gambar"
	if [ -z "$var" ] ; then
		echo "$var is not set : exit"
		exit 2
	else
		export $gamvar
	fi
done

function gam() {
	python $GAM_PY $@
}

function listGroups() {
	gam print groups 2>/dev/null | grep -v GroupID 
}

function listFromGroup() {
	gam info group "$1"
}

function addToGroup() {
	gam update group "$GAM_GROUP" add member "$1"
}

function removeFromGroup() {
	gam update group "$GAM_GROUP" remove member "$1"
}

export -f removeFromGroup
export -f addToGroup
export -f listGroups
export -f listFromGroup

#if [ ${#@} -ne 0 ] ; then
#	$@
#fi
