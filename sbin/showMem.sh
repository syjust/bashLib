#!/bin/bash
kb_to_gb=$((1024*1024))
print_pattern="%-9s RAM = %3s GB\n"
for i in Total Available Free ; do
    mem=`awk '$1 ~ /Mem'$i'/ {print $2}' /proc/meminfo`
    printf "$print_pattern" "$i" "$(($mem/$kb_to_gb))"
done
