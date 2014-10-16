#!/bin/bash

[ -z "$GAM_GROUP" ] && GAM_GROUP=""
[ -z "$GAM_PY" ] && GAM_PY="python/gam/gam.py"
[ -z "$GAM_PYTHON" ] && GAM_PYTHON="/usr/bin/python"

function quit() {
	echo "$0 > bashLib/lib/gamGroup.sh : $1" >&2
	exit 1
}

# check GAM_* & executable
for gamvar in ${!GAM_*} ; do
	# GAM_GROUP is not mandatory (keep it for ancestor compatibility)
	if [ $gamvar != "GAM_GROUP" ] ; then
		eval "var=\$$gamvar"
		if [ -z "$var" ] ; then
			quit "$gamvar is not set : exit"
		else
			export $gamvar
		fi
	fi
done
[ ! -x "$GAM_PYTHON" ] && quit "$GAM_PYTHON is not executable"
[ ! -e "$GAM_PY" ] && quit "$GAM_PY no such file or directory"

# check versions
function checkGamVersion() {
	local python_version major minor patch python
	local python_version_def="`$GAM_PYTHON --version 2>&1 | awk 'BEGIN { FS="[ .]" } {printf "python=%s;major=%s;minor=%s;patch=%s;", $1, $2, $3, $4}'`"
	eval $python_version_def
	if [ -z "$major" ] ; then
		quit "python version not found"
	else
		if [ $major -eq 2 ] ; then
			return 0
		else
			quit "$GAM_PYTHON : BAD VERSION ($python $major.$minor.$patch), BUT 2.x.x is required"
		fi
	fi
}

checkGamVersion || exit 1

function gam() {
	$GAM_PYTHON $GAM_PY $@
}
function setDefaultGroup() {
	local mess="$1"
	if [ -z "$GAM_GROUP" ] ; then
		quit "if GAM_GROUP is not set, $mess"
	else
		[ -z "$group" ] && group="$GAM_GROUP"
	fi
}

function listGroups() {
	gam print groups 2>/dev/null | grep -v GroupID 
}

function listFromGroup() {
	local group="$1"
	[ -z "$group" ] && setDefaultGroup "listFromGroup need group as first arg"
	gam info group "$group"
}

function addToGroup() {
	local member="$1"
	local group="$2"
	[ -z "$member" ] && quit "addToGroup need member as first arg"
	[ -z "$group" ] && setDefaultGroup "addToGroup need group as second arg"
	gam update group "$group" add member "$member"
}

function removeFromGroup() {
	local member="$1"
	local group="$2"
	[ -z "$member" ] && quit "removeFromGroup need member as first arg"
	[ -z "$group" ] && setDefaultGroup "removeFromGroup need group as second arg"
	gam update group "$group" remove member "$member"
}

export -f setDefaultGroup
export -f removeFromGroup
export -f addToGroup
export -f listGroups
export -f listFromGroup

#if [ ${#@} -ne 0 ] ; then
#	$@
#fi

