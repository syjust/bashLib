#!/bin/bash
BAR="================================================================================"

function get_func() {
	echo func:$FUNCNAME
	echo func0:${FUNCNAME[0]}
	echo func1:${FUNCNAME[1]}
	echo func2:${FUNCNAME[2]}
	echo $BAR
	local toget=${1:?First arg needed}
	local _2=${2:-foo}
	local _X=_2
	local _3=${3:=baz}
	local _4=${4:+bar}
	echo -e "DO get_func:$toget, 2:$_2($2), 3:$_3($3), 4:$_4($4)\n"
	for i in ${FUNCNAME[@]} ; do
		echo f:$i
	done
	echo "![@]: '${!FUNCNAME[@]}'"
	echo "!_X : '$_X=${!_X}'"
	echo "!_2 : '${!_2}'"
	echo "!_* : '${!_*}'"
	for i in ${!_*} ; do
		if [ $i == _X ] ; then
			echo "double indirection"
			x=${!i}
			echo $i:${!i}:${!x}
			#echo $i:${!i}:${!${!i}}
		else
			echo $i:${!i}
		fi
	done
}

function main_func() {
	echo func:$FUNCNAME
	echo func0:${FUNCNAME[0]}
	echo func1:${FUNCNAME[1]}
	echo func2:${FUNCNAME[2]}
	echo $BAR
	echo -e "DO main_func\n"
	get_func $FUNCNAME TOTO TITI TATA
	get_func $FUNCNAME TOTO TITI
	get_func $FUNCNAME TOTO
	get_func $FUNCNAME
	get_func
}
main_func
