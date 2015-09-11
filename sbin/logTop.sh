#!/bin/bash
# this script is used by cron to make a `top` periodically and log it in topc_list_file
# after logging, you can use watchTopLogs.sh for display content of each file logged here
# NOTE: ~/.toprc is used for output definition and topline sorting
#       For configure your .toprc, read the man page and launch top in interactive mode

top_out="$HOME/top/top.`date "+%Y%m%d%H%M%S"`.txt"
topc_list_file="$HOME/.topc.list"
top -b -n1 > $top_out
echo $top_out >> $topc_list_file
