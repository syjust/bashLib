#!/bin/bash
#
set -Eeuio pipefail
source lib/helper.inc.sh

# {{{ TRAP ERRORS & EXIT + quit override
quit() {
    echo
    err "$@"
    echo
    trap - EXIT
    exit 1
}
on_error(){
  trap - EXIT
  err "SOME ERROR OCCURRED"
}
on_exit(){
  err "SCRIPT EXITED PREMATURLY (UNCAUGHT ERROR ?)"
}
on_debug(){
  info "debug '$@'"
}
on_sigint(){
  err "SIGINT RECEIVED"
  #trap - EXIT
  #exit 1
}
on_sigkill(){
  err "SIGKILL RECEIVED"
  #trap - EXIT
  #exit 1
}
on_139(){
  err "1, 3 or 9 RECEIVED"
  #trap - EXIT
  #exit 1
}
on_sigterm(){
  err "SIGTERM RECEIVED"
  #trap - EXIT
  #exit 1
}

trap 'on_error'  ERR
trap 'on_exit'   EXIT
trap 'on_sigint' SIGINT
trap 'on_sigkill' SIGKILL
trap 'on_139' 1 3 9
trap 'on_sigint' SIGTERM
#trap 'on_debug' DEBUG

#TODO: enhance traps with `trap -l`
#  1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL
#  5) SIGTRAP	 6) SIGABRT	 7) SIGEMT	 8) SIGFPE
#  9) SIGKILL	10) SIGBUS	11) SIGSEGV	12) SIGSYS
# 13) SIGPIPE	14) SIGALRM	15) SIGTERM	16) SIGURG
# 17) SIGSTOP	18) SIGTSTP	19) SIGCONT	20) SIGCHLD
# 21) SIGTTIN	22) SIGTTOU	23) SIGIO	24) SIGXCPU
# 25) SIGXFSZ	26) SIGVTALRM	27) SIGPROF	28) SIGWINCH
# 29) SIGINFO	30) SIGUSR1	31) SIGUSR2	
# }}}


# run tests previously added
PID=$$
info "running tests with pid:$PID"
trap -p
count=0
while [[ $count -le 9999 ]] ; do
    printf "%s [pid:%s] iteration number #%04d\n" "$0" "$PID" "$count"
    let count++
    sleep 1
done

# {{{ END OF FILE: ALL TESTS ARE OK (untrap EXIT)
trap - EXIT
succ "SCRIPT FINISHED WITH SUCCESS"
# }}}
