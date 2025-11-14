#!/bin/bash
# Build a logo in logo image with imagemagick
# TODO: manage transparentify colors
# TODO: manage corner where to put on (default is top-right)
# TODO: manage circle output (in and main)

# {{{ function usage
# #
usage(){
    echo
    echo "This script builds a logo in logo image with imagemagick."
    echo
    echo "USAGE: $0 [OPTIONS] MAIN_IMAGE IN_IMAGE"
    echo
    echo "Where OPTIONS could be:"
    echo "  -h|--help           Prints this message and exits without errors."
    echo "  -d|--debug          Dry Run and print debugs instead of doing the ImageMagick Action."
    echo "  -s|--size {SIZE}    Override the default main size (128 that will produce a 128x128px main logo with a 32x32 in-logo image)."
    echo
}
export -f usage
# }}}

# {{{ function quit
# #
quit(){
    echo
    echo -e "ERROR: $@"
    usage
    exit 1
}
export -f quit
# }}}

# {{{ function set_args
# #
set_args(){
    local arg="$1"
    if [[ -z "$MAIN_IMAGE" ]] ; then
        export MAIN_IMAGE="$arg"
        return 0
    fi
    if [[ -z "$IN_IMAGE" ]] ; then
        export IN_IMAGE="$arg"
        return 0
    fi
    quit "'$arg': WTF!!! Both required args 'MAIN_IMAGE' and 'IN_IMAGE' are already set!"

}
export -f set_args
# }}}

# {{{ function check_variables
# #
check_variables(){
    local MAIN_IMAGE="$1"
    local IN_IMAGE="$2"
    local SIZE="$3"
    i=0
    i_ext="th"
    for var in MAIN IN ; do
        let i++
        case $i in
            1) i_ext="st" ;;
            2) i_ext="nd" ;;
            3) i_ext="rd" ;;
            *) i_ext="th" ;;
        esac
        var_name="${var}_IMAGE"
        if [[ -z "${!var_name}" ]] ; then
            quit "'$var_name' must be set as ${i}${i_ext} arg!"
        fi
        if [[ ! -r "${!var_name}" ]] ; then
            quit "'${!var_name}': $var_name file (${i}${i_ext} arg) is not a valid file or not readable!"
        fi
    done
    if [[ ! $SIZE =~ ^[0-9]+$ ]] ; then
        quit "'$SIZE': invalid {SIZE} (only digits are allowed here)"
    fi
}
export -f check_variables
# }}}

# {{{ function run
# #
run(){
    check_variables "$1" "$2" "$3"

    local main_image="$1"
    local in_image="$2"
    local size="$3"
    local in_size="$(($size/4))"
    local pad_size="$(($size-$in_size))"

    local main_title="$(basename "${main_image%%.*}")"
    local in_title="$(basename "${in_image%%.*}")"
    local target_main_file="$(mktemp -p /tmp -t "${main_title// /_}.png")"
    local target_in_file="$(mktemp -p /tmp -t "${in_title// /_}.png")"
    local target_file="${in_title// /_}-in-${main_title// /_}.png"
    echo -e "\nWorking on $target_title\n"
    if [[ $DEBUG -eq 1 ]] ; then
        echo -e "DEBUG\n"
        echo "convert -resize ${size}x${size} \"$main_image\" \"$target_main_file\""
        echo "convert -transparent \#ffffff -resize ${in_size}x${in_size} \"$in_image\" \"$target_in_file\""
        echo "magick \( -page +0+0 \"$target_main_file\" \) \( -page +$pad_size+0 \"$target_in_file\" \) -mosaic \"$target_file\""   # top-right
        #echo "magick \( -page +0+0 \"$target_main_file\" \) \( -page +80+96 \"$target_in_file\" \) -mosaic \"$target_file\"" # bottom-right
        echo "rm -v \"$target_main_file\" \"$target_in_file\""
        rm -v "$target_main_file" "$target_in_file"
        echo
        return 0
    fi

    convert -resize ${size}x${size}  "$main_image" "$target_main_file"
    convert -transparent \#ffffff -resize ${in_size}x${in_size}  "$in_image" "$target_in_file"
    magick \( -page +0+0 "$target_main_file" \) \
        \( -page +$pad_size+0 "$target_in_file" \) \
        -mosaic "$target_file"
    local ret=$?
    rm "$target_main_file" "$target_in_file"
    [[ $ret -eq 0 ]] \
    && echo -e "\nYou can find the result image in '$target_file' file.\n" \
    || quit "Fail to build the '$target_file' file."


}
export -f run
# }}}

export MAIN_IMAGE=""
export IN_IMAGE=""
export SIZE="128"
DEBUG=0
while [[ ! -z "$1" ]] ; do
    case $1 in
        -h|--help) usage ; exit 0 ;;
        -d|--debug) DEBUG=1 ;;
        -s|--size) [[ -z "$2" ]] && quit "--size option needs a valid size argument" || SIZE=$2 ; shift ;;
        *) set_args "$1" ;;
    esac
    shift
done

run "$MAIN_IMAGE" "$IN_IMAGE" "$SIZE"
