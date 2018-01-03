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

doIt() {
    local t="$1"
    local date="`getDate`:"
    case $t in
        Espace_disques)
            df -h | sed "s/^/$date    /"
        ;;
        RAM_/_CPU_Usage)
            top -b -n1 | head -n 20 | sed "s/^/$date    /"
        ;;
        IO_tests)
            iostat -d 2 5 | sed "s/^/$date    /"
        ;;
        MAJ_des_Paquet)
            apt-get update --quiet --assume-yes > /dev/null 2>&1
            apt-get upgrade --dry-run | grep -vE "(Inst|Conf)" | sed "s/^/$date    /"
        ;;
        *)
            log "    WTF $t"
    esac
}
export -f doIt

looping() {
    local t
    for t in $TESTS ; do
        log "$U_SEP"
        log "${t//_/ } :"
        log "$D_SEP"
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
