#!/bin/bash

# This script is included in my .bashrc to find and rename easily and recursivly
# files and directories containing ASCII extended or ['-`()\[\]] chars

# {{{ function riname: Rename a file without space or special chars (and with date prefix if flag is set)
#
# USAGE: riname [OPTIONS] SOURCE
#
# Options:
#   -d|--debug          Enable debug mode (dry-run). Repeat for verbosity: -dd for very verbose
#   -D|--with-date      Add date prefix formatted as 'YYYYMMDD-' from file timestamp
#   -h|--help           Display usage information
#
# Arguments:
#   SOURCE              File or directory to rename
#
riname_usage() {
    echo "USAGE: riname [OPTIONS] SOURCE"
    echo
    echo "Options:"
    echo "  -d|--debug          Enable debug mode (dry-run). Repeat for verbosity: -dd for very verbose"
    echo "  -D|--with-date      Add date prefix formatted as 'YYYYMMDD-' from file timestamp"
    echo "  -h|--help           Display usage information"
    echo
    echo "Arguments:"
    echo "  SOURCE              File or directory to rename"
}

riname() {
    local source=""
    local debug=0
    local with_date_prefix=0
    local rename_count=0        # if a target already exists, adds an int before extension
    local source_dir=""         # full path folder/ from source and also used as target directory (dirname)
    local source_name=""        # just filename or dirname (without extension) extracted from the source (basename)
    local source_ext=""         # extension extracted from the source but also used as target extension
    local target_name=""        # without without .ext or full path folder/ (source_dir)
    local target=""             # source_dir/target_name.source_ext
    local date_to_add=""        # calculated date to add from file timestamp
    local source_date_prefix="" # already existing date suffix in source (formatted as 'YYYYMMDD-')

    while [[ $# -gt 0 ]] ; do
        case "$1" in
            -h|--help)
                riname_usage
                return 0
                ;;
            -d*)
                local flag="${1#-}"
                while [[ "$flag" == d* ]]; do
                    let debug++
                    flag="${flag#d}"
                done
                shift
                ;;
            --debug)
                let debug++
                shift
                ;;
            -D|--with-date)
                with_date_prefix=1
                shift
                ;;
            -*)
                echo "riname: unknown option '$1'" >&2
                riname_usage >&2
                return 1
                ;;
            *)
                source="$1"
                shift
                ;;
        esac
    done

    [[ $debug -eq 0 ]] && debug="${DEBUG:-0}"
    [[ $with_date_prefix -eq 0 ]] && with_date_prefix="${WITH_DATE:-0}"

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
    if [[ "$source" == "${source_dir}${source_ext}" ]] ; then
        # no extension found (probably a directory => './DIR ITEM'
        source_name="`basename "${source}"`"
        source_ext=""
    else
        source_name="`basename "${source/.$source_ext}"`"
    fi
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
    if [[ $debug -eq 2 ]] ; then
        echo "[DEBUG] source='$source'" >&2
        echo "[DEBUG] source_dir='$source_dir'" >&2
        echo "[DEBUG] source_ext='$source_ext'" >&2
        echo "[DEBUG] source_name='$source_name'" >&2
        echo "[DEBUG] target_name='$target_name'" >&2
    fi

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
        if [[ $debug -ge 1 ]] ; then
            echo "riname: nothing to do with '$source' - [DEBUG] target:'$target_name' === source:'$source_name'" >&2
        else
            echo "riname: nothing to do with '$source'" >&2
        fi
        return 0
    fi
    if [[ -z "$source_ext" ]] ; then
        target="$source_dir/$target_name"
    else
        target="$source_dir/$target_name.$source_ext"
    fi
    if [[ -e "$source_dir/$target" ]] ; then
        while [[ -e "$source_dir/$target" ]] ; do
            let rename_count++;
            if [[ -z "$source_ext" ]] ; then
                target="$source_dir/$target_name.$rename_count"
            else
                target="$source_dir/$target_name.$rename_count.$source_ext"
            fi
        done
    fi
    if [[ $debug -ge 1 ]] ; then
        echo "[DEBUG] riname (debug): mv -v '$source' -> '$target'" >&2
    else
        mv -v "$source" "$target" >&2
    fi
}
export -f riname
# }}}

# {{{ function find_and_rename: find directories (firstly) & files (secondly) into given folder at given proof and apply riname() function on it
#
# USAGE: find_and_rename [OPTIONS] [FOLDER] [PROOF]
#
# Options:
#   -d|--debug          Enable debug mode (dry-run). Repeat for verbosity: -dd for very verbose
#   -D|--with-date      Add date prefix formatted as 'YYYYMMDD-' from file timestamp
#   -h|--help           Display usage information
#
# Arguments:
#   FOLDER              Path to search (default: ./)
#   PROOF               Max search depth (default: 0 = unlimited)
#
# @see riname()
#
find_and_rename_usage() {
    echo "USAGE: find_and_rename [OPTIONS] [FOLDER] [PROOF]"
    echo
    echo "Options:"
    echo "  -d|--debug          Enable debug mode (dry-run). Repeat for verbosity: -dd for very verbose"
    echo "  -D|--with-date      Add date prefix formatted as 'YYYYMMDD-' from file timestamp"
    echo "  -h|--help           Display usage information"
    echo
    echo "Arguments:"
    echo "  FOLDER              Path to search (default: ./)"
    echo "  PROOF               Max search depth (default: 0 = unlimited)"
}

function find_and_rename() {
    local dir=""
    local proof=""
    local debug=0
    local with_date_prefix=0
    local positional_args=()

    while [[ $# -gt 0 ]] ; do
        case "$1" in
            -h|--help)
                find_and_rename_usage
                return 0
                ;;
            -d*)
                local flag="${1#-}"
                while [[ "$flag" == d* ]]; do
                    let debug++
                    flag="${flag#d}"
                done
                shift
                ;;
            --debug)
                let debug++
                shift
                ;;
            -D|--with-date)
                with_date_prefix=1
                shift
                ;;
            -*)
                echo "find_and_rename: unknown option '$1'" >&2
                find_and_rename_usage >&2
                return 1
                ;;
            *)
                positional_args+=("$1")
                shift
                ;;
        esac
    done

    dir="${positional_args[0]:-./}"
    proof="${positional_args[1]:-0}"
    local max=""

    export DEBUG="$debug"
    export WITH_DATE="$with_date_prefix"

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
            find ./ -mindepth $max -maxdepth $max ! -regex ".*\.git.*" -type d -exec bash -c 'riname "$0"' {} \;
            find ./ -mindepth $max -maxdepth $max ! -regex ".*\.git.*" -type f -exec bash -c 'riname "$0"' {} \;
        done
        cd - >&2
    else
        echo "'$dir' is not a valid folder !!!" >&2
    fi
}
export -f find_and_rename
# }}}
