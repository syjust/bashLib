#!/bin/bash
#
# This lib provides default options for write scripts with options and arguments
# default functions provided are :
# * output
#   - log
#   - info
#   - success
#   - warn
#   - err
#   - debug
#   - quit
# * option managment and usage
#   - usage
#   - options (need some delcarations in script to limit option section)
# * Constants
#   - KERNEL
#
# @see color.sh
# @TODO check arguments after options
# @TODO add default options (help / debug / verbose)
#

[ -z "$BASH_LIB" ] && echo "bashLib path not found" && exit 1
source $BASH_LIB/lib/color.sh

#############
# FUNCTIONS #
#############

#
# echo with date & clear colors
# @param $1 (string)
# @return $2 (or 0)
#
log() {
    echo -e "`date "+%Y-%M-%D %H:%M:%S"` : $@"
    tput sgr0
}

#
#
#
debug() {
    local debug=${DEBUG:-0}
    if [ $debug -ne 0 ] ; then
        warn "DEBUG : $@"
    fi
}

#
# do an action and log it with success or error
# do not apply if DEBUG is enabled
# @param $1 as action (and shift it)
# @param $@ as params
# @return int (as action return)
#
doIt() {
    local debug=${DEBUG:-0}
    if [ $debug -ne 0 ] ; then
        local action="debug $1"
    else
        local action=$1
    fi
    shift
    info "${action}ing ..."
    $action $@
    local ret=$?
    [ $ret -eq 0 ] \
        && succ "${action}ing ... SUCCESS" \
        || err "${action}ing ... ERROR"
    return $ret
}

#
# | log
#
logn() {
    IFS=$'\r\n'
    while read line ; do
        log $line
    done
}

#
# log green
#
succ() {
    log "${BGREEN_COLOR}$@"
}

#
# log cyan
#
info() {
    log "${BCYAN_COLOR}$@"
}

#
# log yellow
#
warn() {
    log "${BYELLOW_COLOR}$@"
}

#
# log red
#
err() {
    log "${BRED_COLOR}$@"
}

#
# err with ERROR and exit 1
#
quit() {
    echo
    err "ERROR : $@"
    usage
    echo
    exit 1
}

#
# grep OPTIONS definitions
# need ## OPTIONS & ## END OPTIONS definitions
#
options() {
    local start=`grep -m 1 -En "^[[:blank:]]*## OPTIONS" $0 2>/dev/null | awk -F: '{print $1}'`
    local end=`grep -m 1 -En "^[[:blank:]]*## END OPTIONS" $0 2>/dev/null | awk -F: '{print $1}'`
    [ -z "$start" -o -z "$end" ] && quit "function 'options' need a ## [END] OPTIONS declaration in case switch script section"
    local head="$((${end}))"
    local tail="$((${end}-${start}))"
    [ $tail -lt 1 ] && quit "function 'options' suppose ## OPTIONS must be declared before ## END OPTIONS"
    head -n$head $0 | tail -n$tail \
        | sed 's/^[[:blank:]]\{1,\}\([^)]*\))\([[:blank:]]\{1,\}\)[^#]*#/    \1)\2/' \
        | grep -E "^[[:blank:]]*-" \
        | logn
}

#
# basic usage with options
#
usage() {
    log
    info "USAGE : $0 [OPTIONS]"
    log
    warn "WHERE OPTIONS are :"
    options
}


#############
# CONSTANTS #
#############
KERNEL="`uname -s`"

###########
# EXPORTS #
###########
export -f quit log succ warn err info options usage
export -p KERNEL
