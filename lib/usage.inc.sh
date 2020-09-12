#!/bin/bash

# {{{ function print_usage_options
#
print_usage_options() {
    local file="$1"

    [[ -z "$file" ]] \
        && echo "WARN:print_usage_options, no file given" \
        && return 1
    [[ ! -e $file ]] \
        && echo "WARN:print_usage_options, '${file}' file not found" \
        && return 2

    sed -n '/^[[:blank:]]*case/,/^[[:blank:]]*esac/p' ${file} \
        | sed 's/^[[:blank:]]*//g;s/).*#/) #/;' \
        | awk -F# '$1 ~ /)/ {printf "\t%-25s:%s\n", $1, $2}' \
        | grep -vE "^[[:blank:]]*\*\)|;;"
}
export -f print_usage_options
# }}}
