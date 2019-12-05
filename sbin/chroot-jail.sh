#!/bin/bash
SCRIPT="`basename $0`"

# {{{ BASE LOG, DISPLAY & EXIT FUNCTIONS

# {{{ colors variables declaration
export    _esc="\033[0m"     # Text Reset
export  _black="\033[01;30m" # Black
export    _red="\033[01;31m" # Red
export  _green="\033[01;32m" # Green
export _yellow="\033[01;33m" # Yellow
export   _blue="\033[01;34m" # Blue
export _purple="\033[01;35m" # Purple
export   _cyan="\033[01;36m" # Cyan
export  _white="\033[01;37m" # White
export  _white_on_red="\033[1;37;41m"
export  _white_on_blue="\033[1;37;44m"
# }}}

# {{{ function log
#
log() {
    local ls_args=""
    while [[ "x${1:0:1}" == "x-" ]] ; do
        ls_args="$ls_args $1" ; shift
    done
    echo ${ls_args} "[`date "+%F %T"`]: $@"
}
export -f log
# }}}

# {{{ function color_and_prefix
#
color_and_prefix() {
    local ls_args="-e"
    local color="$1" ; shift
    while [[ "x${1:0:1}" == "x-" ]] ; do
        ls_args="$ls_args $1" ; shift
    done
    local prefix="`echo ${FUNCNAME[1]} | tr [[:lower:]] [[:upper:]]`"
    log ${ls_args} "${!color}$prefix : $@${_esc}"
}
export -f color_and_prefix
# }}}

# {{{ function debug
#
export DEBUG=0
debug() {
    if [[ $DEBUG -eq 1 ]] ; then
        color_and_prefix _purple $@
    fi
}
export -f debug
# }}}

# {{{ function success
#
success() {
    color_and_prefix _white $@
}
export -f success
# }}}

# {{{ function error
#
error() {
    color_and_prefix _white_on_red $@
}
export -f error
# }}}

# {{{ function warning
#
warning() {
    color_and_prefix _yellow $@
}
export -f warning
# }}}

# {{{ function info
#
question() {
    color_and_prefix _white_on_blue $@
}
export -f question
# }}}

# {{{ function info
#
info() {
    color_and_prefix _cyan $@
}
export -f info
# }}}

# {{{ function quit
#
quit() {
    error "${FUNCNAME[1]}: $@"
    exit 1
}
export -f quit
# }}}

# {{{ function yes_no
#
export FORCE_YES=0
yes_no() {
    if [[ ${FORCE_YES} -ne 1 ]] ; then
        local mess="$@"
        local resp
        while true ; do
            question "$mess (y/n) ?"
            read resp
            case ${resp} in
                [yY]|[yY][eE][sS]) return 0 ;;
                [nN]|[nN][oO]) return 1 ;;
                *) warning "'$resp' : bad resp ! please answer with 'yes' or 'no' ('y' or 'n')." ;;
            esac
        done
    fi
    return 0
}
export -f yes_no
# }}}

# }}}

[[ "x$UID" == "x0" ]] || quit "run '$SCRIPT' as ROOT only"

ROOT_DIRS="proc var/git etc bin dev lib lib64 tmp"
LIBS_FILE="`mktemp /tmp/temp.XXXXXX`"
ONLY_LIB_FILE="`mktemp /tmp/temp.XXXXXX`"
CHROOT_HOME="`pwd`"

yes_no "do you want make a jail in '$CHROOT_HOME'" \
    || quit "'$CHROOT_HOME' is not your jail folder ? so, go where you want to work"

# {{{ /bin/chrootuser generation
info "/bin/chrootuser generation"
cat <<EOF > /bin/chrootuser
#!/bin/bash
exec -c /usr/sbin/chroot /home/\$USER /bin/bash
EOF
chmod 555 /bin/chrootuser
# }}}
 
mkdir -vp $CHROOT_HOME
cd $CHROOT_HOME
 
# {{{ APPS definition
APPS="/bin/bash
/usr/bin/host
/usr/bin/dircolors
/usr/bin/nslookup
/bin/ping
/usr/bin/strace
/usr/bin/git
/usr/bin/getent
/usr/bin/ssh
/usr/bin/git-receive-pack
/usr/bin/git-shell
/usr/bin/git-upload-archive
/usr/bin/git-upload-pack
/bin/touch
/bin/grep
/usr/bin/find
/usr/bin/screen
/usr/bin/mysql
/usr/bin/who
/usr/bin/whoami
/bin/cp
/bin/ls
/bin/mkdir
/bin/mv
/bin/rm
/bin/rmdir
/usr/bin/id
/usr/bin/rsync
/usr/bin/scp
/usr/bin/wget
/usr/bin/curl
/usr/bin/php
/usr/bin/vim
/usr/bin/vi
/bin/cat
/bin/less
/usr/bin/tail
/usr/bin/clear
/bin/chmod
/bin/chown
/bin/chgrp
/usr/bin/which
"
# }}}

# {{{ LINKS definition
LINKS="/etc/passwd
/etc/ld.so.cache
/etc/hosts
/selinux
/usr/lib/locale/locale-archive
/usr/share/locale/locale.alias
/usr/share/git-core/
/etc/gitconfig
/etc/group
/etc/nsswitch.conf
/etc/resolv.conf
/etc/shadow
/usr/share/vim/
/usr/lib/php5/
/usr/share/locale/locale.alias
/usr/share/locale/fr/LC_MESSAGES/coreutils.mo
/usr/share/php
/usr/share/php5
/usr/share/fonts
/usr/share/doc/php-pear
/usr/share/javascript
/etc/ssh/moduli
`ls /etc/ssh/ssh_host*key{,.pub}`
`ls /lib/x86_64-linux-gnu/lib{nss,nsl}_*`
"
#`ls /lib/libpng12*`
#`ls /usr/lib/lib{gd,mcrypt,mysqlclient_r,X11,Xpm,png,jpeg,freetype,t1,ltdl}*`
# }}}

info "making root directories"
for dir in $ROOT_DIRS ; do
	[ -d "$dir" ] || mkdir -pv $dir
done
# chmod tmp
[ -d tmp ] && chmod 1777 tmp

info "making nodes files"
[ ! -e dev/tty ] && mknod -m 666 dev/tty c 5 0
[ ! -e dev/null ] && mknod -m 0666 dev/null c 1 3
[ ! -e dev/zero ] && mknod -m 0666 dev/zero c 1 5
[ ! -e dev/random ] && mknod -m 644 dev/random c 1 8
[ ! -e dev/urandom ] && mknod -m 644 dev/urandom c 1 9


info "linking what should be linked"
for link in $LINKS ; do
	if [ ! -e .$link -a -e $link ] ; then
		link_path=`dirname $link`
		[ -d .$link_path ] || mkdir -vp .$link_path
		#[ -e $link ] || ln $link .$link
        # in chroot env, links does not works
		[ -e .$link ] || cp -va $link .$link
		for file in `find $link -type f` ; do
			info "ldd dynamic $link => $file"
			ldd $file >> ${LIBS_FILE}
		done
	fi
done

info "copying apps & generating lib tmpfile"
for app in $APPS;  do
	if [ ! -x .$app -a -x $app ] ; then
        app_path=`dirname $app`
        [ -d .$app_path ] || mkdir -vp .$app_path
        cp -vp $app .$app
        ldd $app >> ${LIBS_FILE}
	fi
done
 
info "copying libs from from tmpfile"
if [ -e ${LIBS_FILE} ] ; then
    for lib in `cat $LIBS_FILE` ; do
        [[ "x${lib:0:1}" == 'x/' ]] && echo $lib >> $ONLY_LIB_FILE
    done
    for lib in `sort ${ONLY_LIB_FILE} | uniq`; do
        dir=`dirname $lib`
        [ -d .$dir ] || mkdir -vp .$dir
        [ -e .$lib ] || cp -vp $lib .$lib
    done
fi
rm -vf $LIBS_FILE $ONLY_LIB_FILE
 
info "copying terminfo"
[ -e ./lib/terminfo ] || cp -vr /lib/terminfo ./lib/terminfo

# you can now :
# - adduser <chroot_user>
# - adduser <chroot_user> <chroot_group>
# - modify sshd_config with following instructions :
#   Match Group <chroot_group>
#   ChrootDirectory $CHROOT_HOME
# - restart sshd
# - try to connect with <chroot_user> over ssh

