#!/bin/bash
TESTS="
Espace_disques
RAM_/_CPU_Usage
IO_tests
MAJ_des_Paquet
"
DATE="`date '+%Y%m%d_%H%M%S'`"
HOSTNAME="`hostname`"
LOG="${0/.sh/-$DATE.log}"
# base separator
B_SEP="################################################################################"
# up separator
U_SEP="________________________________________________________________________________"
# down separator
D_SEP="¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"

getDate() {
    echo "[`date '+%F %T'`]"
}
export -f getDate

log() {
 echo -e "`getDate`: $1"
}
export -f log

starting() {
    log "$B_SEP"
    log "STARTING $0 on $HOSTNAME"
    log "$B_SEP"
}
export -f starting

title() {
    local t="$1"
    shift
    log "$U_SEP"
    log "${t//_/ } : '$@'"
    log "$D_SEP"
}
export -f title

doIt() {
    local t="$1"
    local date="`getDate`:"
    case $t in
        Espace_disques)
            title "$t" "df -h"
            df -h | sed "s/^/$date    /"
        ;;
        RAM_/_CPU_Usage)
            title "$t" "top -b -n1"
            top -b -n1 | head -n 20 | sed "s/^/$date    /"
        ;;
        IO_tests)
            title "$t" "iostat -d 2 5"
            iostat -d 2 5 | sed "s/^/$date    /"
        ;;
        MAJ_des_Paquet)
            title "$t" "apt-get upgrade --dry-run"
            apt-get update --quiet --assume-yes > /dev/null 2>&1
            apt-get upgrade --dry-run | grep -vE "(Inst|Conf)" | sed "s/^/$date    /"
        ;;
        *)
            title $t WTF
            log "    What The F*** $t"
    esac
}
export -f doIt

looping() {
    local t
    for t in $TESTS ; do
        doIt $t
        log
    done
}
export -f looping

ending() {
    log "$B_SEP"
    log "ENDING $0 on $HOSTNAME"
    log "log can be found in $LOG file"
    log "$B_SEP"
}
export -f ending

# running script
starting | tee -a $LOG
looping  | tee -a $LOG
ending   | tee -a $LOG
