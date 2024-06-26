#!/bin/bash
# create a circle from given image using imagemagick
quit() {
    echo "ERROR: $1"
    exit 1
}

[ -z "$1" ] && quit "first arg must be provided"
[ ! -e "$1" ] && quit "first arg must be provided as valid input file"
[ -z "$2" ] && quit "second arg must be provided as output file"

convert $1 \
        -gravity Center \
        \( -size 200x200 \
           xc:Black \
           -fill White \
           -draw 'circle 100 100 100 1' \
           -alpha Copy \
        \) -compose CopyOpacity -composite \
        -trim $2
