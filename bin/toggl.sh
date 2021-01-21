#!/bin/bash

###########################################
#   C O N F I G   &   C O N S T A N T S   #
###########################################

CONFIG="$HOME/.toggl/config"
TOGGL_API_URL="https://www.toggl.com/api/v8"
TOGGL_TIME_ENTRIES_URL="$TOGGL_API_URL/time_entries"


#########################
#   F U N C T I O N S   #
#########################

# {{{ function usage
#
usage() {
    echo
    echo "USAGE :"
    echo "$0 COMMAND [ARGS] [XID]"
    echo
    echo "WHERE AVAILABLES COMMANDS ARE :"
    echo "  h|help               display this message and exit"
    echo "  c|clients            list / details clients"
    echo "  p|projects           list / details projects"
    echo "  w|workspaces         list / details workspaces"
    echo "  T|tasks              list / details tasks"
    echo "  t|tags               list (only) tags"
    echo "  C|create-time-entry  create a time entry"
    echo "  r|report             (reports details - not implemented)"
    echo
    echo "AND WHERE :"
    echo "  XID can be workspaces id / tasks id / clients id / projects id"
    echo "  ARGS are only available for 'create-time-entry' COMMAND (use 'C --help' for more informations"
    echo
}
export -f usage
# }}}

# {{{ function backtrace
#
backtrace() {
    local func_id cnt=${1:-1}
    echo "BACKTRACE : "
    for func_id in ${!FUNCNAME[@]} ; do
        [ $func_id -ge $cnt ] \
            && echo "$func_id:${FUNCNAME[$func_id]}"
    done
}
export -f backtrace
# }}}

# {{{ function quit
#
quit() {
    echo
    echo -e "ERROR : $1"
    backtrace 2
    usage
    exit 1
}
export -f quit
# }}}

[[ -r $CONFIG ]] && source $CONFIG || quit "'$CONFIG' file not found or not readable"

# {{{ function curl_get
#
curl_get() {
    local cmd="$1" url="$2" opt="-u '$TOGGL_API_KEY:api_token'"
    echo "curl ${opt} -X GET $url"
    local json="`eval "curl $opt -X GET $url 2>/dev/null" | python -m json.tool`"
    echo "$json"
    if [[ -z "$XID" && "x$cmd" != 'xtags' ]] ; then
       XID="`choose_id "$json"`"
       $0 $cmd $WID $XID || backtrace
    fi
}
export -f curl_get
# }}}

# {{{ function choose_id
#
choose_id() {
    local json="$1"
    select id_name in `extract_ids_from_json "$json"` ; do
        echo "${id_name%%:*}"
        break
    done
}
export -f choose_id
# }}}

# {{{ function extract_ids_from_json
#
extract_ids_from_json() {
    local json="$1"
    local id name
    local ids="`echo "$json" | awk -F: '$1 ~ /"id"/ {print $2}' | sed 's/[,[:blank:]]//g'`"
    local names=(`echo "$json" | awk -F: '$1 ~ /"name"/ {print $2}' | sed 's/[",[:blank:]]//g'`)
    local cnt=0
    for id in $ids ; do
        name=${names[$cnt]}
        echo "$id:${name// /_}"
        let cnt++
    done
}
export -f extract_ids_from_json
# }}}

# {{{ function time_entry_quit
#
time_entry_quit() {
    time_entry_usage
    echo
    quit "$@"
}
export -f time_entry_quit
# }}}

# {{{ function time_entry_usage
#
time_entry_usage() {
    echo
    echo "CREATE-TIME-ENTRY USAGE : $0 create-time-entry ARGS"
    echo
    echo "WHERE REQUIERED ARGS ARE :"
    echo
    echo "  -h|--help          print this message & exit"
    echo "  -d|--description   {string}"
    echo "  -s|--start-at      {string} formatted as : '2012-12-27T13:00:00+02:00'"
    echo "  -D|--duration      {int} in seconds (ie: 3600)"
    echo "  -t|--tags          {string} space separated (@see $0 tags to retrieve a tags NAMES)"
    echo "  -p|--project-id    {int}    (@see $0 projects to retrieve a project ID)"
    echo "  -c|--csv           {file}   a CSV file semicolon separated for bulk creations (not already implemented)"
    echo
}
export -f time_entry_usage
# }}}

# {{{ function create_time_entry
#
create_time_entry() {
    local description start_at duration tags pid
    while [ ! -z "$1" ] ; do
        case $1 in 
            -h|--help) time_entry_usage        ; exit 0 ;;
            -d|--description) description="$2" ; shift ;;
            -s|--start-at)    start_at="$2"    ; shift ;;
            -D|--duration)    duration="$2"    ; shift ;;
            -t|--tags)        tags="$2"        ; shift ;;
            -p|--project-id ) pid="$2"         ; shift ;;
            -c|--csv)         time_entry_quit "--csv is not already implemented" ;;
            *)                time_entry_quit "'$1' : WTF !!!"
        esac
        shift
    done
    local var val
    for var in description start_at duration tags pid ; do
        val="${!var}"
        [[ -z "$val" || "x${val:0:1}" == "-" ]] && time_entry_quit "'$var' is not set or is not valid"
    done

    data="{\"time_entry\":{\"description\":"
    data="${data}\"${description}\""
    data="${data}"',"tags":['
    local tag cnt=0
    for tag in $tags ; do
        if [ $cnt -ne 0 ] ; then
            data="${data},"
        fi
        data="${data}\"${tag}\""
    done
    data="${data}],\"duration\":$duration"
    data="${data},\"start\":\"$start_at\",\"pid\":$pid,\"created_with\":\"curl\"}}"
    local content_type="Content-Type: application/json"
    echo "curl -u $TOGGL_API_KEY:api_token -H \"$content_type\" -d $data -X POST $TOGGL_TIME_ENTRIES_URL"
    curl -u $TOGGL_API_KEY:api_token -H "$content_type" -d $data -X POST $TOGGL_TIME_ENTRIES_URL
}
export -f create_time_entry
# }}}

# {{{ function toggl
# toggl curl actions
# https://github.com/toggl/toggl_api_docs/blob/master/chapters/workspaces.md
#
toggl() {
    local url
    local cmd="${FUNCNAME[1]}"
    if [ -z "$XID" ] ; then
        if [ "x${cmd}" == "xworkspaces" ] ; then
            url="$TOGGL_API_URL/$cmd"
        else
             url="$TOGGL_API_URL/workspaces/$TOGGL_DEFAULT_WORKSPACE/$cmd"
        fi
    else
        url="$TOGGL_API_URL/$cmd/$XID"
    fi

    if [ "x$url" != "x$TOGGL_API_URL" ] ; then
        curl_get $cmd $url
    else
        quit "bad $FUNCNAME url construction ($url)"
    fi

}
export -f toggl
# }}}

# {{{ function workspaces
#
workspaces() {
    toggl $@
}
export -f workspaces
# }}}

# {{{ function clients
#
clients() {
    toggl $@
}
export -f clients
# }}}

# {{{ function tags
#
tags() {
    toggl $@
}
export -f tags
# }}}

# {{{ function tasks
#
tasks() {
    toggl $@
}
export -f tasks
# }}}

# {{{ function projects
#
projects() {
    toggl $@
}
export -f projects
# }}}

#################
#   T E S T S   #
#################

for const in TOGGL_API_KEY TOGGL_DEFAULT_WORKSPACE ; do
    [[ -z "${!const}" ]] && quit "'$const' constant should be declared into your '$CONFIG' file"
done

#########################
#   A R G U M E N T S   #
#########################

CMD=$1
shift
XID=$1

###########################
#   R U N   S C R I P T   #
###########################

case $CMD in
    h|help) usage ; exit 0 ;;
    c) clients    $XID ;;
    p) projects   $XID ;;
    w) workspaces $XID ;;
    T) tasks      $XID ;;
    t) tags       $XID ;;
    C|create-time-entry) create_time_entry $@ ;;
    tags|clients|projects|workspaces|tasks) $CMD $XID ;;
    r|reports) quit "reports is not already implemented" ;;
    *) quit "'$CMD' unknown command" ;;
esac
