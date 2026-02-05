#!/bin/bash
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

trap 'on_error'  ERR
trap 'on_exit'   EXIT

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

# {{{ function run_test + useful test functions
is_fn() {
    local fn_type="$(LC_ALL=C type -t $1)"
    [ ! -z "$fn_type" -a  "$fn_type" = function ]
}

run_test() {
    is_fn "$1" || quit "run_test must have valid function as first arg"
    local test_func="$1"
    local test_name
    test_name="`printf "%50s" "${test_func//_/ }" | sed 's/^\([a-z]\)/\u\1/'`"
    info "running $test_name"
    $test_func 2>/dev/null \
        && succ "$test_name: SUCCESS" \
        || quit "$test_name: FAILURE"
}
run_tests() {
    for test_func in `grep -E "^function test_.*()" $0 | sed 's/^function //;s/().*$//;'` ; do
        is_fn set_up && set_up || true
        run_test $test_func
        is_fn tear_down && tear_down || true
    done
}
assertion_fails() {
    local message="$1"
    local line="${BASH_LINENO[1]}"
    local func="${FUNCNAME[1]}"

    #echo "[$func] assertion fails: exit"
    trap - EXIT
    err "$func: $message [L:$line]"
    exit 1
}
assert_file_exists() {
    [[ -e "$1" ]] \
        || assertion_fails "file '$1' should exists at line"
}
assert_file_not_exists() {
    [[ ! -e "$1" ]] \
        || assertion_fails "file '$1' should NOT exists"
}
# }}}

# Includes scripts to test, writes CONSTANTS, set_up & tear_down and implments tests here
source lib/function_riname.sh
TMP_DIR="/tmp/test_function_riname"

set_up() {
    [ -d $TMP_DIR ] && rm -rf $TMP_DIR
    mkdir -p $TMP_DIR
}

tear_down() {
    [ -d $TMP_DIR ] && rm -rf $TMP_DIR
}

function test_find_and_rename_with_date_idempotency() {
    local date="`date '+%Y%m%d'`"
    touch "$TMP_DIR/a b c d.txt"
    find_and_rename --with-date "$TMP_DIR"
    assert_file_exists "$TMP_DIR/$date-a_b_c_d.txt"
    find_and_rename --with-date "$TMP_DIR"
    assert_file_exists "$TMP_DIR/$date-a_b_c_d.txt"
}

function test_find_and_rename_idempotency() {
    assert_file_not_exists "$TMP_DIR/a_b_c_d.txt"
    touch "$TMP_DIR/a b c d.txt"
    find_and_rename $TMP_DIR
    assert_file_exists "$TMP_DIR/a_b_c_d.txt"
    find_and_rename $TMP_DIR
    assert_file_exists "$TMP_DIR/a_b_c_d.txt"
}

function test_find_and_rename_increment_count_if_exists() {
    touch "$TMP_DIR/a b c d.txt"
    find_and_rename $TMP_DIR
    assert_file_exists "$TMP_DIR/a_b_c_d.txt"
    assert_file_not_exists "$TMP_DIR/a_b_c_d.1.txt"
    assert_file_not_exists "$TMP_DIR/a_b_c_d.2.txt"
    touch "$TMP_DIR/a b c d.txt"
    find_and_rename $TMP_DIR
    assert_file_exists "$TMP_DIR/a_b_c_d.1.txt"
    touch "$TMP_DIR/a b c d.txt"
    find_and_rename $TMP_DIR
    assert_file_exists "$TMP_DIR/a_b_c_d.2.txt"
}

function test_find_and_rename_default_proof_is_one() {
    mkdir -p "$TMP_DIR/level1/level2"
    touch "$TMP_DIR/root file.txt"
    touch "$TMP_DIR/level1/first file.txt"
    touch "$TMP_DIR/level1/level2/second file.txt"
    find_and_rename "$TMP_DIR"
    assert_file_exists "$TMP_DIR/root_file.txt"
    assert_file_not_exists "$TMP_DIR/level1/first_file.txt"
    assert_file_exists "$TMP_DIR/level1/first file.txt"
    assert_file_not_exists "$TMP_DIR/level1/level2/second_file.txt"
    assert_file_exists "$TMP_DIR/level1/level2/second file.txt"
}

function test_find_and_rename_proof_zero_is_unlimited() {
    mkdir -p "$TMP_DIR/level1/level2/level3"
    touch "$TMP_DIR/root file.txt"
    touch "$TMP_DIR/level1/first file.txt"
    touch "$TMP_DIR/level1/level2/second file.txt"
    touch "$TMP_DIR/level1/level2/level3/third file.txt"
    find_and_rename --proof 0 "$TMP_DIR"
    assert_file_exists "$TMP_DIR/root_file.txt"
    assert_file_exists "$TMP_DIR/level1/first_file.txt"
    assert_file_exists "$TMP_DIR/level1/level2/second_file.txt"
    assert_file_exists "$TMP_DIR/level1/level2/level3/third_file.txt"
}

function test_find_and_rename_proof_two() {
    mkdir -p "$TMP_DIR/level1/level2/level3"
    touch "$TMP_DIR/root file.txt"
    touch "$TMP_DIR/level1/first file.txt"
    touch "$TMP_DIR/level1/level2/second file.txt"
    touch "$TMP_DIR/level1/level2/level3/third file.txt"
    find_and_rename -p 2 "$TMP_DIR"
    assert_file_exists "$TMP_DIR/root_file.txt"
    assert_file_exists "$TMP_DIR/level1/first_file.txt"
    assert_file_not_exists "$TMP_DIR/level1/level2/second_file.txt"
    assert_file_exists "$TMP_DIR/level1/level2/second file.txt"
    assert_file_not_exists "$TMP_DIR/level1/level2/level3/third_file.txt"
    assert_file_exists "$TMP_DIR/level1/level2/level3/third file.txt"
}

function test_find_and_rename_combined_flags() {
    local date="`date '+%Y%m%d'`"
    mkdir -p "$TMP_DIR/subdir/another"
    touch "$TMP_DIR/test file.txt"
    touch "$TMP_DIR/subdir/first file.txt"
    touch "$TMP_DIR/subdir/another/second file.txt"
    find_and_rename --with-date -p 2 "$TMP_DIR"
    assert_file_exists "$TMP_DIR/$date-test_file.txt"
    assert_file_exists "$TMP_DIR/$date-subdir/$date-first_file.txt"
    assert_file_not_exists "$TMP_DIR/$date-subdir/another/$date-second_file.txt"
    assert_file_exists "$TMP_DIR/$date-subdir/another/second file.txt"
}

# run tests previously added
run_tests

# {{{ END OF FILE: ALL TESTS ARE OK (untrap EXIT)
trap - EXIT
succ "ALL TESTS ARE OK"
# }}}
