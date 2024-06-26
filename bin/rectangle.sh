#!/bin/bash
# create a white png rectangle from given size (default is 100x100) using imagemagick
# TODO: add file & color as argument (-c, -f)
size=${1:-100x100}
color="ffffff"
file="rectangle-$size.jpeg"

quit() {
    echo "ERROR: $1"
    exit 1
}

[[ -e "$file" ]] && quit "file '$file' already exists"
    #-size $size xc:"#$color" \
convert \
    -type "TrueColor" \
    -colors "256" \
    -size $size xc:"rgb(255,255,255)" \
    $file
