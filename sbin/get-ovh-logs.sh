#!/bin/bash
#OVH_LOGS_URL="logs.ovh.net"
[[ -e last_error ]] && rm last_error
OVH_LOGS_URL="logs.cluster002.hosting.ovh.net"
ALL_DAYS="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"
ALL_MONTHES="01 02 03 04 05 06 07 08 09 10 11 12"
THIS_YEAR="`date "+%Y"`"

function usage() {
    echo
    echo "usage: $0 domain.tld [cookie_file_name] [year(s)] [month(s)] [day(s)]"
    echo
    echo "default cookie_file_name is cookie.txt"
    echo "default year is $THIS_YEAR"
    echo "default monthes ar all monthes in a year"
    echo "default days ar all days in all monthes"
    echo
    echo "assume to load a valid cookie from ovh"
    echo
    exit
}
function quit() {
    echo
    echo "ERREUR: $@"
    echo
    [[ -e last_error ]] && cat last_error && echo
    echo
    exit 1
}
for arg in $@ ; do
    [[ "x-h" = "x$arg" ]] && usage
done

DOMAIN="$1"
COOKIE="${2:-cookie.txt}"
YEARS="${3:-$THIS_YEAR}"
MONTHES="${4:-${ALL_MONTHES}}"
DAYS="${5:-${ALL_DAYS}}"
[[ ! -e "$COOKIE" ]] && quit "'$COOKIE' : cookie_file NOT FOUND"

echo
echo "# $DOMAIN $USER $PASS => GO";

function getLog() {
    local year="${1}"
    local month="${2}"
    local day="${3}"
    wget \
        --load-cookies $COOKIE \
        --no-check-certificate \
        https://${OVH_LOGS_URL}/${DOMAIN}/logs/logs-${month}-${year}/${DOMAIN}-${day}-${month}-${year}.log.gz
}
NOT_FOUND=0
for year in $YEARS ; do
    for month in $MONTHES ; do
        for day in $DAYS ; do
            getLog ${year} ${month} ${day} > last_error 2>&1
            case $? in
                0) echo "# ${year}-${month}-${day} DONE" ; NOT_FOUND=0 ;;
                6) quit "# ${year}-${month}-${day} 401 UNAUTHORIZED" ;;
                8) echo "# ${year}-${month}-${day} 404 NOT FOUND" ; let NOT_FOUND++ ;;
                *) quit "# ${year}-${month}-${day} ERROR $?" ;; 
            esac
            if [[ $NOT_FOUND -gt 3 ]] ; then
                quit "# ${year}-${month}-${day} TOO MANY 404 NOT FOUND (${NOT_FOUND})"
            fi
        done
    done
done
echo
