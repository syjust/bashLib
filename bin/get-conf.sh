#!/bin/bash
# aya <aya@sys.ht>
set -e
exit=1

# Function: get_blocks file
# Return : list of blocks in a file
get_blocks()
{
    block=$(
        awk -F '[][]' '
        NF==3 && $0 ~ /^\[.*\]/ { print $2 }
        ' $1 )
    [ -n "$block" ] && echo "$block" && exit=0 || exit=2
}

# Function : get_config file block
# Return : get variables from block in file
get_config()
{
    typeset file=$1
    typeset block=$2
    typeset config

    config=$(
        awk -F= -v Config="${block}" '
        BEGIN {
            patternConfig = "\\[" Config "]";
        }
        $0 ~ patternConfig,(/\[/ && $0 !~ patternConfig) {
            if (/^(\[|#)/ || NF <2) next;
            gsub(/ *= */, "=");
#            gsub(/\|/, "\\|");
#            gsub(/</, "\\<");
#            gsub(/>/, "\\>");
            gsub(/\$/, "\\$");
            print $0;
        } ' ${file} )

    [ -n "$config" ] && echo "${config}" && exit=0 || exit=3
}

# [ -f "$1" ] && [ -r "$1" ] || exit $exit
[ -n "$1" ] || exit $exit
[ -z "$2" ] && get_blocks "$1" || get_config "$1" "$2"
exit $exit
