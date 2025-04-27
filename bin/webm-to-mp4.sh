#!/bin/bash
# TODO: tess params
ffmpeg -fflags +genpts -i "$1" -r 24 "${1/.webm/.mp4}"
