#!/bin/bash

HERE="$(pwd)"
export DEBUG=0
export VERBOSE=1

# {{{ function usage
# #
usage() {
    echo
    echo "$0: find files in the first level of FILE_OR_DIR and rename it with the date of the file"
    echo
    echo "USAGE: $0 [OPTIONS] FILE_OR_DIR"
    echo
    echo "Where OPTIONS could be:"
    echo "    -h|--help)       print this usage and exit without error"
    echo "    -d|--debug)      set debug (dry-run, don't execute the replacement)"
    echo "    -v|--verbose)    display more informations on stdin (can be called multiple until to 3 times to increase verbosity)."
    echo "    -V|--no-verbose) decrease verbosity (default is 1)."
    echo "    -f|--filter)     filter result with given \"regex\" (@see find -name available regex)"
}
export -f usage
# }}}

# {{{ function quit
# #
quit() {
    echo "$@"
    exit 1
}
export -f quit
# }}}

# {{{ function prefixDate
# #
prefixDate() {
    local file="$1"
    [ ! -z "$file" ] || quit "function prefixDate: file required as first arg."
    [ ! -e "$file" ] && quit "'$file': file not found."
    local prefix="$(date -r "$file" "+%Y%m%d")"
    local dir="$(dirname "$file")"
    local base="$(basename "$file")"
    if [[ "${base:0:8}" =~ ^[0-9]{8}$ ]] ; then
        if [[ $VERBOSE -ge 2 ]] ; then
            echo "'$file': already date prefixed"
        fi
        return 0
    fi
    if [[ $DEBUG -eq 1 ]] ; then
        echo "DEBUG: mv '$file' '$dir/$prefix-$base'"
    else
        if [[ $VERBOSE -gt 1 ]] ; then
            mv -v "$file" "$dir/$prefix-$base"
        fi
    fi
    
}
export -f prefixDate
# }}}

while [ ! -z "$1" ] ; do
    case $1 in
        -h|--help)    usage ; exit 0 ;;
        -d|--debug)   export DEBUG=1 ;;
        -v|--verbose) let VERBOSE++ ;;
        -V|--no-verbose) let VERBOSE-- ;;
        -f|--filter)  export FILTER="$2" ; shift ;;
        -*) quit "'$1': unknown option" ;;
        *)
        [ -z "$DIR" ] \
            && DIR="${1}" \
            || quit "DIR already set to '$DIR', unable to to anything with '$1'"
        ;;
    esac
    shift
done
export VERBOSE="$VERBOSE"

[ -z "$DIR" ] && DIR="./"


if [ "$HERE" = "/" ] ; then
    if [ "$DIR" = "." -o "$DIR" = "./" ] ; then
        quit "$0 can't be launched from / with ./ or . as argument"
    fi
fi
if [ "$DIR" = "/" ] ; then
        quit "$0 can't be launched into /"
fi
if [ ! -e "$DIR" ] ; then
    quit "'$DIR': file or dir not found"
fi

if [ -z "$FILTER" ] ; then
    find $DIR -maxdepth 1 -type f -exec bash -c 'prefixDate "$0"' {} \;
else
    find $DIR -maxdepth 1 -type f -name "$FILTER" -exec bash -c 'prefixDate "$0"' {} \;
fi
