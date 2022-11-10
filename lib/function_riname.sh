#!/bin/bash

# This script is included in my .bashrc to find and rename easily and recursivly
# files and directories containing ASCII extended or ['-`()\[\]] chars

# {{{ function riname: Rename a file without space or special chars (and with date prefix if flag is set as third arg)
#
# @param string {source} as file or folder to rename
# @param int {debug} as debug flag - default 0 (1 => true / dry-run)
# @param int {with_date_prefix} - default 0 (1 => add a date prefix formatted as 'YYYYMMDD-')
#
riname() {
    local source="$1" # file or folder with .ext & full path folder/ (source_dir)
    local debug="${2:-0}"
    local with_date_prefix="${3:-0}"
    local rename_count=0        # if a target already exists, adds an int before extension
    local source_dir=""         # full path folder/ from source and also used as target directory (dirname)
    local source_name=""        # just filename or dirname (without extension) extracted from the source (basename)
    local source_ext=""         # extension extracted from the source but also used as target extension
    local target_name=""        # without without .ext or full path folder/ (source_dir)
    local target=""             # source_dir/target_name.source_ext
    local date_to_add=""        # calculated date to add from file timestamp
    local source_date_prefix="" # already existing date suffix in source (formatted as 'YYYYMMDD-')


    if [[ -z "$source" ]]  ; then
        echo "riname: source not found ($source)" >&2
        return 0
    fi

    if [ ! -e "$source" -a ! -d "$source" ] ; then
        echo "riname: file or folder does not exists : '$source'" >&2
        return 0
    fi

    source_dir="`dirname "$source"`"
    source_ext="${source##*.}"
    source_name="`basename "${source/.$source_ext}"`"
    target_name="`
        echo "${source_name}" \
            | sed "
                s/[[:blank:]()'’_¿?]\{1,\}/_/g;
                s/_-_/-/g;
                s/[àâä]/a/g;
                s/[ÀÂÄ]/A/g;
                s/[çç]/c/g;
                s/[ÇÇ]/C/g;
                s/[ééèêêë]/e/g;
                s/[ÉÉÈÊÊË]/E/g;
                s/Ee/E_/g;
                s/ee/e_/g;
                s/[ôô]/o/g;
                s/[ÔÔ]/O/g;
                s/[ùûû]/u/g;
                s/[ÙÛÛ]/U/g;
                s/[ïïî]/i/g;
                s/[ÏÏÎ]/I/g;
            " \
    `"

    if [[ $with_date_prefix -eq 1 ]] ; then
        source_date_prefix="${source_name%%-*}"
        if [[ "$source_date_prefix" =~ ^(19|20)[0-9]{2}(1[12]|0[1-9])([012][0-9]|3[01])$ ]] ; then
            echo "riname: '$source' has already a valid date prefix ($source_date_prefix)" >&2
        else
            date_to_add="`stat -f "%Sm" -t "%Y%m%d" "$source"`"
            target_name="$date_to_add-$target_name"
        fi
    fi

    if [[ "$target_name" == "$source_name" ]] ; then
        echo "riname: nothing to do with '$source'" >&2
        return 0
    fi
    target="$source_dir/$target_name.$source_ext"
    if [[ -e "$source_dir/$target" ]] ; then
        while [[ -e "$source_dir/$target" ]] ; do
            let rename_count++;
            target="$source_dir/$target_name.$rename_count.$source_ext"
        done
    fi
    if [[ $debug -eq 1 ]] ; then
        echo "riname (debug): mv -v '$source' -> '$target'" >&2
    else
        mv -v "$source" "$target" >&2
    fi
}
export -f riname
# }}}

# {{{ function d_riname
#
# @param string {source} as file or folder to rename
#
# @see riname()
#
d_riname() {
    riname "$1" 1 0
}
export -f d_riname
# }}}

# {{{ function d_riname_with_date_prefix
#
# @param string {source} as file or folder to rename
#
# @see riname()
#
d_riname_with_date_prefix() {
    riname "$1" 1 1
}
export -f d_riname_with_date_prefix
# }}}

# {{{ function find_and_rename: find directories (firstly) & files (secondly) into given {folder} at given {proof} and apply riname() function on it
#
# @param string  {folder} as path where to find - default ./
# @param integer {proof} as proof to find - default 0 (0 => max depth accessible in folder)
# @param int     {debug} as debug flag - default 0 (1 => true / dry-run)
# @param int     {with_date_prefix} - default 0 (1 => add a date prefix formatted as 'YYYYMMDD-')
#
# @see riname()
#
function find_and_rename() {
    local dir="${1:-./}"
    local proof="${2:-0}"
    local debug="${3:-0}"
    local with_date_prefix="${4:-0}"
    local max=""
    if [[ -d "$dir" ]] ; then
        cd "$dir" >&2
        [[ $? -ne 0 ]] && echo "find_and_rename: can't go into folder '$dir'" >&2 && return 1
        [[ `pwd` == "/" ]] && echo "find_and_rename: can't perform search in root folder !!!" >&2 && return 2
        ( ! [[ $proof =~ ^[0-9]+$ ]] ) && echo "find_and_rename: '$proof' => bad proof" >&2 && return 3

        if [[ $proof -eq 0 ]] ; then
            local i=""
            for i in `find ./ -type d | awk -F/ '{print NF}'` ; do
                [[ $i -gt $proof ]] && proof=$i
            done
        fi
        for max in `seq 1 $proof` ; do
            find ./ -mindepth $max -maxdepth $max ! -regex ".*\.git.*" -type d -exec bash -c 'riname "$0" "$1" "$2"' {} $debug $with_date_prefix \;
            find ./ -mindepth $max -maxdepth $max ! -regex ".*\.git.*" -type f -exec bash -c 'riname "$0" "$1" "$2"' {} $debug $with_date_prefix \;
        done
        cd - >&2
    else
        echo "'$dir' is not a valid folder !!!" >&2
    fi
}
export -f find_and_rename
# }}}

# {{{ function d_find_and_rename: call function find_and_rename with debug flag (dry-run)
#
# @param string  {folder} as path where to find - default ./
# @param integer {proof} as proof to find - default 0 (0 => infinity)
#
# @see find_and_rename()
#
#
d_find_and_rename() {
    find_and_rename "${1:-./}" "${2:-0}" 1 0
}
export -f d_find_and_rename
# }}}

# {{{ function find_and_rename_with_date: call function find_and_rename with with_date_prefix flag
#
# @param string  {folder} as path where to find - default ./
# @param integer {proof} as proof to find - default 0 (0 => infinity)
#
# @see find_and_rename()
#
#
find_and_rename_with_date() {
    find_and_rename "${1:-./}" "${2:-0}" 0 1
}
export -f find_and_rename_with_date
# }}}

# {{{ function d_find_and_rename_with_date: call function find_and_rename with with_date_prefix & debug flags (dry-run)
#
# @param string  {folder} as path where to find - default ./
# @param integer {proof} as proof to find - default 0 (0 => infinity)
#
# @see find_and_rename()
#
#
d_find_and_rename_with_date() {
    find_and_rename "${1:-./}" "${2:-0}" 1 1
}
export -f d_find_and_rename_with_date
# }}}
