#!/bin/bash
# this script is used to centralize all htaccess of a VirtualHost
# then use AllowOverride None for a better
# prerequisites : use apache2 VirtualHost

# ROOT & CONF examples
#ROOT="/var/www/my/site/path"
#CONF="/etc/apache2/sites-available/my-site.conf"

# ROOT & CONF definitions (edit it manually)
ROOT=""
CONF=""

# {{{ function quit
#
quit() {
    echo "$1" >&2
    exit 1
}
export -f quit
# }}}

[ -z "$ROOT" ] && quit "'ROOT' root directory not defined. edit me to set ROOT"
[ -z "$CONF" ] && quit "'CONF' config file not defined. edit me to set CONF"
[ -d "$ROOT" ] || quit "'$ROOT' root directory not found"
[ -f "$CONF" ] || quit "'$CONF' config file not found"
grep -q "</VirtualHost>" "$CONF" > /dev/null 2>&1 \
    || quit "no </VirtualHost> found in '$CONF' config file"

# {{{ function getContentAsDirectory
#
getContentAsDirectory() {
    local file="$1"
    local dir="`dirname "${htaccess/./}"`"
    echo "        <Directory \"${dir}\">"
    sed 's/^/            /' "$file"
    echo "        </Directory>"
}
export -f getContentAsDirectory
# }}}

# {{{ function addInLine
#
addInLine() {
local before=0
[ "x$1" == "x-b" ] && before=1 && shift
local expression="$1"
local replacement="$2"
local file="$3"
if ! (grep -q "$expression" "$file" >/dev/null 2>&1) ; then
    quit "'$expression' : expression not found in file '$file'"
fi
if [ $before -eq 1 ] ; then
sed -i 's@\(^.*'"$expression"'\)@'"$replacement"' \
\1@i' "$file"
else
sed -i 's@\(^.*'"$expression"'\)@\1 \
'"$replacement"'@i' "$file"
fi
}
export -f addInLine
# }}}

# {{{ function insertContent : insert or replace content between lead & tail expressions
#
insertContent() {
    local lead="$1"
    local tail="$2"
    local from_file="$3"
    local to_file="$4"
    local match="###htaccess" # this is for filter keeped content
    sed -e '/'"$lead"'/,/'"$tail"'/{/'"$match"'/!d}' \
        -e '/'"$lead"'/r '"$from_file" \
        --in-place $to_file

}
export -f insertContent
# }}}

# {{{ function printDirectoryFromHtaccess
#
printDirectoryFromHtaccess() {
    local htaccess="$1"
    local htaccess_code="code${htaccess//\//-}"
    local content="`getContentAsDirectory "$htaccess"`"
    local tmp_file="/tmp/$htaccess_code"
    local sha1="`sha1sum "$htaccess" | awk '{print $1}'`"
    local oldSha1="`awk -F: '$1 ~ /###htaccessBegin/ && $2 ~ /'"$htaccess_code"'/ {print $3}' "$CONF"`"

    echo "$content" > "$tmp_file"
    if [ -z "$oldSha1" ] ; then
        echo "'$htaccess': new entry" >&2
        addInLine -b \
            "        ###LastVirtualHostConfLine" \
            "        ###htaccessBegin:${htaccess_code}:$sha1" \
            "$CONF" \
        && addInLine \
            "        ###htaccessBegin:${htaccess_code}:$sha1"  \
            "        ###htaccessEnd:$htaccess_code" "$CONF" \
        && insertContent \
            "###htaccessBegin:${htaccess_code}:$sha1" \
            "###htaccessEnd:${htaccess_code}" \
            "$tmp_file" \
            "$CONF"
        return $?
    fi
    if [ "x${oldSha1// /}" != "x${sha1// /}" ] ; then
        echo "'$htaccess': old entry differ" >&2
        insertContent \
            "###htaccessBegin:${htaccess_code}:$oldSha1" \
            "###htaccessEnd:${htaccess_code}" \
            "$tmp_file" \
            "$CONF" \
        && sed -i "s/###htaccessBegin:${htaccess_code}:$oldSha1/###htaccessBegin:${htaccess_code}:$sha1/" $CONF
        return $?
    fi
    echo "'$htaccess' old is same" >&2
    return $?
}
export -f printDirectoryFromHtaccess
# }}}

# {{{ function run
#
run() {
    local backup="${CONF}-`date "+%Y%m%d%H%M%S"`.bak"
    grep -q "###LastVirtualHostConfLine" $CONF > /dev/null \
        || addInLine -b "</VirtualHost>" "        ###LastVirtualHostConfLine" "$CONF"
    cp -v $CONF $backup
    #find $ROOT -name .htaccess -exec bash -c 'printDirectoryFromHtaccess "$0"' {} \;
    for htaccess in `find $ROOT -name .htaccess` ; do
        printDirectoryFromHtaccess "$htaccess"
        break
    done
    diff -q $backup $CONF && rm -v $backup
}
export -f run
# }}}

run
#run >> $CONF
