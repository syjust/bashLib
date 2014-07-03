#!/bin/bash

[ -z "$GAM_GROUP" ] && GAM_GROUP=""
[ -z "$GAM_PY" ] && GAM_PY="python/gam/gam.py"

for gamvar in ${!GAM_*} ; do
	eval "var=\$$gamvar"
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
	local group="$1"
	[ -z "$group" ] && group="$GAM_GROUP"
	gam info group "$group"
}

function addToGroup() {
	local member="$1"
	local group="$2"
	[ -z "$member" ] && echo "addToGroup need member as first arg" && exit 1
	[ -z "$group" ] && group="$GAM_GROUP"
	gam update group "$group" add member "$member"
}

function removeFromGroup() {
	local member="$1"
	local group="$2"
	[ -z "$member" ] && echo "removeFromGroup need member as first arg" && exit 1
	[ -z "$group" ] && group="$GAM_GROUP"
	gam update group "$group" remove member "$member"
}

export -f removeFromGroup
export -f addToGroup
export -f listGroups
export -f listFromGroup

#if [ ${#@} -ne 0 ] ; then
#	$@
#fi
