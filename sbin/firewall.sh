#!/bin/bash
# ---------------------------------------------------------------------- |
#                     This is it...MonMotha's Firewall 2.3.8!            |
#    It's been a year I tell you, a whole damn year...but it's here      |
# |!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! |
# |!*******************************************************************! |
# |!** http://www.mplug.org/phpwiki/index.php?MonMothaReferenceGuide **! |
# |!*******************************************************************! |
# |!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! |
# ---------------------------------------------------------------------- |
#                                                                        |
# ALL USERS, READ THE FOLLOWING:                                         |
#                                                                        |
# This is distributed under the BSD liscense sans advertising clause:    |
#                                                                        |
# Redistribution and use in source and binary forms, with or without     |
# modification, are permitted provided that the following conditions     |
# are met:                                                               |
#                                                                        |
#    1.Redistributions of source code must retain the above copyright    |
#      notice, this list of conditions and the following disclaimer.     |
#    2.Redistributions in binary form must reproduce the above           |
#      copyright notice, this list of conditions and the following       |
#      disclaimer in the documentation and/or other materials provided   |
#      with the distribution.                                            |
#    3.The name of the author may not be used to endorse or promote      |
#      products derived from this software without specific prior        |
#      written permission.                                               |
#                                                                        |
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR   |
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED         |
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE     |
# ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY         |
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL     |
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE      |
# GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS          |
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER   |
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR        |
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN    |
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE                           |
#                                                                        |
# While this may be used freely for commercial use, I do REQUEST that    |
# any commercial users please tell me via e-mail at                      |
# monmotha@indy.rr.com that they are using it, why they chose it,        |
# how well it works, etc.                                                |
#                                                                        |
# ---------------------------------------------------------------------- |

#modprobe ip_conntrack_ftp

# Main Options
IPTABLES="/sbin/iptables"
TCP_ALLOW="21 22 80 443"
UDP_ALLOW=""
INET_IFACE="eth0"
LAN_IFACE=""
INTERNAL_LAN=""
MASQ_LAN=""
SNAT_LAN=""
DROP="TREJECT"
DENY_ALL=""
DENY_HOSTWISE_TCP=""
DENY_HOSTWISE_UDP=""
BLACKHOLE=""
BLACKHOLE_DROP="DROP"
#ALLOW_HOSTWISE_TCP=""
ALLOW_HOSTWISE_TCP=""
ALLOW_HOSTWISE_UDP=""
TCP_FW=""
UDP_FW=""
MANGLE_TOS_OPTIMIZE="FALSE"
DHCP_SERVER="FALSE"
BAD_ICMP="5 9 10 15 16 17 18"
ENABLE="Y"

# Flood Params
LOG_FLOOD="100/s"
SYN_FLOOD="200/s"
PING_FLOOD="3/s"

# Outbound filters
ALLOW_OUT_TCP=""
PROXY=""
MY_IP=""

# Below here is experimental (please report your successes/failures)
MAC_MASQ=""         # Currently Broken
MAC_SNAT=""         # Ditto...
TTL_SAFE=""
USE_SYNCOOKIES="FALSE"
RP_FILTER="TRUE"
ACCEPT_SOURCE_ROUTE="FALSE"
SUPER_EXEMPT=""
BRAINDEAD_ISP="FALSE"
ALLOW_HOSTWISE_PROTO=""
BLOCK_ODD_TCP="FALSE"
PROTO_FW=""         # Forwarding of arbitrary IP protocols

# Only touch these if you're daring (PREALPHA stuff, as in basically non-functional)
DMZ_IFACE=""


# ----------------------------------------------------------------------|
# These control basic script behavior; there should be no need to       |
# change any of these settings for normal use.                          |
# ----------------------------------------------------------------------|
FILTER_CHAINS="INETIN INETOUT DMZIN DMZOUT TCPACCEPT UDPACCEPT LDROP LREJECT LTREJECT TREJECT"
UL_FILTER_CHAINS="ULDROP ULREJECT ULTREJECT"
LOOP_IFACE="lo"

# Colors
NORMAL="\033[0m"
GREEN=$'\e[32;01m'
YELLOW=$'\e[33;01m'
RED=$'\e[31;01m'
NORMAL=$'\e[0m'

# Undocumented Features
OVERRIDE_NO_FORWARD="FALSE"
OVERRIDE_SANITY_CHECKS="FALSE"

# ----------------------------------------------------------------------|
# You shouldn't need to modify anything below here                      |
# Main Script Starts                                                    |
# ----------------------------------------------------------------------|

# Let's load it!
echo "Loading iptables firewall:"

# Configuration Sanity Checks
echo -n "Checking configuration..."

if [ "$OVERRIDE_SANITY_CHECKS" = "TRUE" ] ; then
  echo "skipped! If it breaks, don't complain!"
  echo "If there's a reason you needed to do this, please report to the developers list!"
  echo
  echo -n "Wait 5 seconds..."
  sleep 5
  echo "continuing"
  echo
  echo
else
  # Has it been configured?
  if ! [ "$ENABLE" = "Y" ] ; then
    echo
    echo "${RED}You need to *EDIT YOUR CONFIGURATION* and set ENABLE to Y!"
    echo "${YELLOW}End User Liscense Agreement:${NORMAL}"
    echo -n "$GREEN"
    cat << EOF

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

   1.Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   2.Redistributions in binary form must reproduce the above
     copyright notice, this list of conditions and the following
     disclaimer in the documentation and/or other materials provided
     with the distribution.
   3.The name of the author may not be used to endorse or promote
     products derived from this software without specific prior
     written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE

EOF
    echo "${RED}You need to *EDIT YOUR CONFIGURATION* and set ENABLE to Y!${NORMAL}"
    exit 99
  fi

  # It's hard to run an iptables script without iptables...
  if ! [ -x $IPTABLES ] ; then
    echo
    echo "ERROR IN CONFIGURATION: ${IPTABLES} doesn't exist or isn't executable!"
    exit 4
  fi

  # Basic interface sanity
  for dev in ${LAN_IFACE} ; do
    if [ "$dev" = "${DMZ_IFACE}" ] && [ "$dev" != "" ]; then
      echo
      echo "ERROR IN CONFIGURATION: DMZ_IFACE and LAN_IFACE can't have a duplicate interface!"
      exit 1
    fi
  done

  # Create a test chain to work with for system ablilities testing
  ${IPTABLES} -N SYSTEST
  if [ "$?" != "0" ] ; then
    echo
    echo "IPTABLES can't create new chains or the script was interrupted previously!"
    echo "Flush IPTABLES rulesets and chains and try again."
    exit 4
  fi

  # Check for ULOG support
  ${IPTABLES} -A SYSTEST -j ULOG > /dev/null 2>&1
  if [ "$?" = "0" ] ; then
    HAVE_ULOG="true"
  else
    HAVE_ULOG="false"
  fi

  # Check for LOG support
  ${IPTABLES} -A SYSTEST -j LOG > /dev/null 2>&1
  if [ "$?" != "0" ] ; then
    echo
    echo "Your kernel lacks LOG support required by this script. Aborting."
    exit 3
  fi

  # Check for stateful matching
  ${IPTABLES} -A SYSTEST -m state --state ESTABLISHED -j ACCEPT > /dev/null 2>&1
  if [ "$?" != "0" ] ; then
    echo
    echo "Your kernel lacks stateful matching, this would break this script. Aborting."
    exit 3
  fi

  # Check for the limit match
  ${IPTABLES} -A SYSTEST -m limit -j ACCEPT > /dev/null 2>&1
  if [ "$?" != "0" ] ; then
    echo
    echo "Support not found for limiting needed by this script. Aborting."
    exit 3
  fi

  # Check for REJECT
  ${IPTABLES} -A SYSTEST -j REJECT > /dev/null 2>&1
  if [ "$?" != "0" ] ; then
    echo
    echo "Support not found for the REJECT target needed by this script. Aborting."
    exit 3
  fi

  # Check DROP sanity
  if [ "$DROP" = "" ] ; then
    echo
    echo "There needs to be a DROP policy (try TREJECT)!"
    exit 1
  fi
  if [ "$DROP" = "ACCEPT" ] ; then
    echo
    echo "The DROP policy is set to ACCEPT; there is no point in loading the firewall as there wouldn't be one."
    exit 2
  fi
  if [ "$DROP" = "ULDROP" ] || [ "$DROP" = "ULREJECT" ] || [ "$DROP" = "ULTREJECT" ] ; then
    if [ "$HAVE_ULOG" != "true" ] ; then
      echo
      echo "You have selected a ULOG policy, but your system lacks ULOG support."
      echo "Please choose a policy that your system has support for."
      exit 5
    fi
  fi

  # Problems with blackholes?
  if [ "$BLACKHOLE" != "" ] && [ "$BLACKHOLE_DROP" = "" ] ; then
    echo
    echo "You can't use blackholes and not have a policy for them!"
    exit 1
  fi

  # Flush and remove the chain SYSTEST
  ${IPTABLES} -F SYSTEST
  ${IPTABLES} -X SYSTEST

  # Seems ok...
  echo "passed"
fi #from override option

# ===============================================
# ----------------Preprocessing------------------
# ===============================================

# Turn TCP_ALLOW and UDP_ALLOW into ALLOW_HOSTWISE
echo -n "Performing TCP_ALLOW and UDP_ALLOW alias preprocessing..."
if [ "$TCP_ALLOW" != "" ] ; then
  for rule in ${TCP_ALLOW} ; do
    ALLOW_HOSTWISE_TCP="${ALLOW_HOSTWISE_TCP} 0/0>$rule"
  done
fi
if [ "$UDP_ALLOW" != "" ] ; then
  for rule in ${UDP_ALLOW} ; do
    ALLOW_HOSTWISE_UDP="${ALLOW_HOSTWISE_UDP} 0/0>$rule"
  done
fi
echo "done"


# ===============================================
# -------Set some Kernel stuff via SysCTL--------
# ===============================================

# Turn on IP forwarding

if [ "$INTERNAL_LAN" != "" ] && [ "$OVERRIDE_NO_FORWARD" != "TRUE" ] ; then
  echo -n "Checking IP Forwarding..."
  if [ -e /proc/sys/net/ipv4/ip_forward ] ; then
    echo 1 > /proc/sys/net/ipv4/ip_forward
    echo "enabled."
  else
    echo "support not found! This will cause problems if you need to do any routing."
  fi
fi

# Enable TCP Syncookies
echo -n "Checking IP SynCookies..."
if [ -e /proc/sys/net/ipv4/tcp_syncookies ] ; then
  if [ "$USE_SYNCOOKIES" = "TRUE" ] ; then
    echo 1 > /proc/sys/net/ipv4/tcp_syncookies
    echo "enabled."
  else
    echo 0 > /proc/sys/net/ipv4/tcp_syncookies
    echo "disabled."
  fi
else
  echo "support not found, but that's OK."
fi

# Enable Route Verification to prevent martians and other such crud that
# seems to be commonplace on the internet today
echo -n "Checking Route Verification..."
if [ "$INET_IFACE" != "" ] ; then
  for dev in ${INET_IFACE} ; do
    if [ -e /proc/sys/net/ipv4/conf/$dev/rp_filter ] ; then
      if [ "$RP_FILTER" = "TRUE" ] ; then
        echo 1 > /proc/sys/net/ipv4/conf/$dev/rp_filter
        echo -n "activated:$dev "
      else
        echo 0 > /proc/sys/net/ipv4/conf/$dev/rp_filter
        echo -n "disabled:$dev "
      fi
    else
      echo "not found:$dev "
    fi
  done
fi

if [ "$LAN_IFACE" != "" ] ; then
  for dev in ${LAN_IFACE} ; do
    if [ -e /proc/sys/net/ipv4/conf/$dev/rp_filter ] ; then
      if [ "$RP_FILTER" = "TRUE" ] ; then
        echo 1 > /proc/sys/net/ipv4/conf/$dev/rp_filter
        echo -n "activated:$dev "
      else
        echo 0 > /proc/sys/net/ipv4/conf/$dev/rp_filter
        echo -n "disabled:$dev "
      fi
    else
      echo "not found:$dev "
    fi
  done
fi

if [ "$DMZ_IFACE" != "" ] ; then
  if [ -e /proc/sys/net/ipv4/conf/$DMZ_IFACE/rp_filter ] ; then
    if [ "$RP_FILTER" = "TRUE" ] ; then
      echo 1 > /proc/sys/net/ipv4/conf/$DMZ_IFACE/rp_filter
      echo -n "activated:${DMZ_IFACE} "
    else
      echo 0 > /proc/sys/net/ipv4/conf/$DMZ_IFACE/rp_filter
      echo -n "disabled:${DMZ_IFACE} "
    fi
  else
    echo "not found:${DMZ_IFACE} "
  fi
fi
echo

# Tell the Kernel to Ignore Source Routed Packets
echo -n "Refusing Source Routed Packets via SysCtl..."
if [ "$INET_IFACE" != "" ] ; then
  for dev in ${INET_IFACE} ; do
    if [ -e /proc/sys/net/ipv4/conf/$dev/accept_source_route ] ; then
      if [ "$ACCEPT_SOURCE_ROUTE" = "TRUE" ] ; then
        echo "1" > /proc/sys/net/ipv4/conf/$dev/accept_source_route
        echo -n "disabled:$dev "
      else
        echo "0" > /proc/sys/net/ipv4/conf/$dev/accept_source_route
        echo -n "activated:$dev "
      fi
    else
      echo "not found:$dev "
    fi
  done
fi

if [ "$LAN_IFACE" != "" ] ; then
  for dev in ${LAN_IFACE} ; do
    if [ -e /proc/sys/net/ipv4/conf/$dev/accept_source_route ] ; then
      if [ "$ACCEPT_SOURCE_ROUTE" = "TRUE" ] ; then
        echo "1" > /proc/sys/net/ipv4/conf/$dev/accept_source_route
        echo -n "disabled:$dev "
      else
        echo "0" > /proc/sys/net/ipv4/conf/$dev/accept_source_route
        echo -n "activated:$dev "
      fi
    else
      echo "not found:$dev "
    fi
  done
fi

if [ "$DMZ_IFACE" != "" ] ; then
  if [ -e /proc/sys/net/ipv4/conf/$DMZ_IFACE/accept_source_route ] ; then
    if [ "$ACCEPT_SOURCE_ROUTE" = "TRUE" ] ; then
      echo "1" > /proc/sys/net/ipv4/conf/$DMZ_IFACE/accept_source_route
      echo -n "disabled:${DMZ_IFACE} "
    else
      echo "0" > /proc/sys/net/ipv4/conf/$DMZ_IFACE/accept_source_route
      echo -n "activated:${DMZ_IFACE} "
    fi
  else
    echo "not found:${DMZ_IFACE} "
  fi
fi
echo

# ===============================================
# --------Actual NetFilter Stuff Follows---------
# ===============================================

# Flush everything
# If you need compatability, you can comment some or all of these out,
# but remember, if you re-run it, it'll just add the new rules in, it
# won't remove the old ones for you then, this is how it removes them.
echo -n "Flush: "
${IPTABLES} -t filter -F INPUT
echo -n "INPUT "
${IPTABLES} -t filter -F OUTPUT
echo -n "OUTPUT1 "
${IPTABLES} -t filter -F FORWARD
echo -n "FORWARD "
${IPTABLES} -t nat -F PREROUTING
echo -n "PREROUTING1 "
${IPTABLES} -t nat -F OUTPUT
echo -n "OUTPUT2 "
${IPTABLES} -t nat -F POSTROUTING
echo -n "POSTROUTING "
${IPTABLES} -t mangle -F PREROUTING
echo -n "PREROUTING2 "
${IPTABLES} -t mangle -F OUTPUT
echo -n "OUTPUT3"
echo

# Create new chains
# Output to /dev/null in case they don't exist from a previous invocation
echo -n "Creating chains: "
for chain in ${FILTER_CHAINS} ; do
  ${IPTABLES} -t filter -F ${chain} > /dev/null 2>&1
  ${IPTABLES} -t filter -X ${chain} > /dev/null 2>&1
  ${IPTABLES} -t filter -N ${chain}
  echo -n "${chain} "
done
if [ ${HAVE_ULOG} = "true" ] || [ ${HAVE_ULOG} = "" ] ; then
  for chain in ${UL_FILTER_CHAINS} ; do
    ${IPTABLES} -t filter -F ${chain} > /dev/null 2>&1
    ${IPTABLES} -t filter -X ${chain} > /dev/null 2>&1
    ${IPTABLES} -t filter -N ${chain}
    echo -n "${chain} "
  done
fi
echo

# Default Policies
# INPUT policy is drop as of 2.3.7-pre5
# Policy can't be reject because of kernel limitations
echo -n "Default Policies: "
${IPTABLES} -t filter -P INPUT DROP
echo -n "INPUT:DROP "
${IPTABLES} -t filter -P OUTPUT ACCEPT
echo -n "OUTPUT:ACCEPT "
${IPTABLES} -t filter -P FORWARD DROP
echo -n "FORWARD:DROP "
echo

# ===============================================
# -------Chain setup before jumping to them------
# ===============================================

#These logging chains are valid to specify in DROP= above
#Set up LDROP
echo -n "Setting up drop chains chains: "
${IPTABLES} -t filter -A LDROP -p tcp -m limit --limit ${LOG_FLOOD} -j LOG --log-level 6 --log-prefix "TCP Dropped "
${IPTABLES} -t filter -A LDROP -p udp -m limit --limit ${LOG_FLOOD} -j LOG --log-level 6 --log-prefix "UDP Dropped "
${IPTABLES} -t filter -A LDROP -p icmp -m limit --limit ${LOG_FLOOD} -j LOG --log-level 6 --log-prefix "ICMP Dropped "
${IPTABLES} -t filter -A LDROP -f -m limit --limit ${LOG_FLOOD} -j LOG --log-level 4 --log-prefix "FRAGMENT Dropped "
${IPTABLES} -t filter -A LDROP -j DROP
echo -n "LDROP "

#And LREJECT too
${IPTABLES} -t filter -A LREJECT -p tcp -m limit --limit ${LOG_FLOOD} -j LOG --log-level 6 --log-prefix "TCP Rejected "
${IPTABLES} -t filter -A LREJECT -p udp -m limit --limit ${LOG_FLOOD} -j LOG --log-level 6 --log-prefix "UDP Rejected "
${IPTABLES} -t filter -A LREJECT -p icmp -m limit --limit ${LOG_FLOOD} -j LOG --log-level 6 --log-prefix "ICMP Rejected "
${IPTABLES} -t filter -A LREJECT -f -m limit --limit ${LOG_FLOOD} -j LOG --log-level 4 --log-prefix "FRAGMENT Rejected "
${IPTABLES} -t filter -A LREJECT -j REJECT
echo -n "LREJECT "

#Don't forget TREJECT
${IPTABLES} -t filter -A TREJECT -p tcp -j REJECT --reject-with tcp-reset
${IPTABLES} -t filter -A TREJECT -p udp -j REJECT --reject-with icmp-port-unreachable
${IPTABLES} -t filter -A TREJECT -p icmp -j DROP
${IPTABLES} -t filter -A TREJECT -j REJECT
echo -n "TREJECT "

#And LTREJECT
${IPTABLES} -t filter -A LTREJECT -p tcp -m limit --limit ${LOG_FLOOD} -j LOG --log-level 6 --log-prefix "TCP Rejected "
${IPTABLES} -t filter -A LTREJECT -p udp -m limit --limit ${LOG_FLOOD} -j LOG --log-level 6 --log-prefix "UDP Rejected "
${IPTABLES} -t filter -A LTREJECT -p icmp -m limit --limit ${LOG_FLOOD} -j LOG --log-level 6 --log-prefix "ICMP Rejected "
${IPTABLES} -t filter -A LTREJECT -f -m limit --limit ${LOG_FLOOD} -j LOG --log-level 4 --log-prefix "FRAGMENT Rejected "
${IPTABLES} -t filter -A LTREJECT -j TREJECT
echo -n "LTREJECT "

#And ULOG stuff, same as above but ULOG instead of LOG
if [ ${HAVE_ULOG} = "true" ] || [ ${HAVE_ULOG} = "" ] ; then
  ${IPTABLES} -t filter -A ULDROP -p tcp -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LDROP_TCP
  ${IPTABLES} -t filter -A ULDROP -p udp -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LDROP_UDP
  ${IPTABLES} -t filter -A ULDROP -p icmp -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LDROP_ICMP
  ${IPTABLES} -t filter -A ULDROP -f -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LDROP_FRAG
  ${IPTABLES} -t filter -A ULDROP -j DROP
  echo -n "ULDROP "

  ${IPTABLES} -t filter -A ULREJECT -p tcp -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LREJECT_TCP
  ${IPTABLES} -t filter -A ULREJECT -p udp -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LREJECT_UDP
  ${IPTABLES} -t filter -A ULREJECT -p icmp -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LREJECT_UDP
  ${IPTABLES} -t filter -A ULREJECT -f -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LREJECT_FRAG
  ${IPTABLES} -t filter -A ULREJECT -j REJECT
  echo -n "ULREJECT "

  ${IPTABLES} -t filter -A ULTREJECT -p tcp -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LTREJECT_TCP
  ${IPTABLES} -t filter -A ULTREJECT -p udp -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LTREJECT_UDP
  ${IPTABLES} -t filter -A ULTREJECT -p icmp -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LTREJECT_ICMP
  ${IPTABLES} -t filter -A ULTREJECT -f -m limit --limit ${LOG_FLOOD} -j ULOG --ulog-nlgroup 1 --ulog-prefix LTREJECT_FRAG
  ${IPTABLES} -t filter -A ULTREJECT -p tcp -j REJECT --reject-with tcp-reset
  ${IPTABLES} -t filter -A ULTREJECT -p udp -j REJECT --reject-with icmp-port-unreachable
  ${IPTABLES} -t filter -A ULTREJECT -p icmp -j DROP
  ${IPTABLES} -t filter -A ULTREJECT -j REJECT
  echo -n "ULTREJECT "
fi
#newline
echo


# Set up the per-proto ACCEPT chains
echo -n "Setting up per-proto ACCEPT: "

# TCPACCEPT
# SYN Flood "Protection"
${IPTABLES} -t filter -A TCPACCEPT -p tcp --syn -m limit --limit ${SYN_FLOOD} -j ACCEPT
${IPTABLES} -t filter -A TCPACCEPT -p tcp --syn -m limit --limit ${LOG_FLOOD} -j LOG --log-prefix "Possible SynFlood "
${IPTABLES} -t filter -A TCPACCEPT -p tcp --syn -j ${DROP}
${IPTABLES} -t filter -A TCPACCEPT -p tcp ! --syn -j ACCEPT
# Log anything that hasn't matched yet and ${DROP} it since it isn't TCP and shouldn't be here
${IPTABLES} -t filter -A TCPACCEPT -m limit --limit ${LOG_FLOOD} -j LOG --log-prefix "Mismatch in TCPACCEPT "
${IPTABLES} -t filter -A TCPACCEPT -j ${DROP}
echo -n "TCPACCEPT "

#UDPACCEPT
${IPTABLES} -t filter -A UDPACCEPT -p udp -j ACCEPT
# Log anything not UDP and ${DROP} it since it's not supposed to be here
${IPTABLES} -t filter -A UDPACCEPT -m limit --limit ${LOG_FLOOD} -j LOG --log-prefix "Mismatch on UDPACCEPT "
${IPTABLES} -t filter -A UDPACCEPT -j ${DROP}
echo -n "UDPACCEPT "

#Done
echo

# =================================================
# -------------------Exemptions--------------------
# =================================================
if [ "$SUPER_EXEMPT" != "" ] ; then
  echo -n "Super Exemptions: "
  for host in ${SUPER_EXEMPT} ; do
    ${IPTABLES} -t filter -A INPUT -s ${host} -j ACCEPT
    ${IPTABLES} -t filter -A OUTPUT -d ${host} -j ACCEPT
    ${IPTABLES} -t filter -A FORWARD -s ${host} -j ACCEPT
    ${IPTABLES} -t filter -A FORWARD -d ${host} -j ACCEPT
    echo -n "${host} "
  done
  echo
fi


# =================================================
# ----------------Explicit Denies------------------
# =================================================

#Blackholes will not be overridden by hostwise allows
if [ "$BLACKHOLE" != "" ] ; then
  echo -n "Blackholes: "
  for host in ${BLACKHOLE} ; do
    ${IPTABLES} -t filter -A INPUT -s ${host} -j ${BLACKHOLE_DROP}
    ${IPTABLES} -t filter -A OUTPUT -d ${host} -j ${BLACKHOLE_DROP}
    ${IPTABLES} -t filter -A FORWARD -s ${host} -j ${BLACKHOLE_DROP}
    ${IPTABLES} -t filter -A FORWARD -d ${host} -j ${BLACKHOLE_DROP}
    echo -n "${host} "
  done
  echo
fi

if [ "$DENY_ALL" != "" ] ; then
  echo -n "Denying hosts: "
  for rule in ${DENY_ALL} ; do
    echo "$rule" | {
      IFS='<' read lhost dhost
        if [ "$dhost" == "" ] ; then
          ${IPTABLES} -t filter -A INPUT -s ${lhost} -j ${DROP}
          ${IPTABLES} -t filter -A FORWARD -s ${lhost} -j ${DROP}
        else
          ${IPTABLES} -t filter -A INPUT -s ${lhost} -d ${dhost} -j ${DROP}
          ${IPTABLES} -t filter -A FORWARD -s ${lhost} -d ${dhost} -j ${DROP}
        fi
    }
    echo -n "${rule} "
  done
  echo
fi



if [ "$DENY_HOSTWISE_TCP" != "" ] ; then
  echo -n "Hostwise TCP Denies: "
  for rule in ${DENY_HOSTWISE_TCP} ; do
    echo "$rule" | {
      IFS='><' read lhost port dhost
        echo "$port" | {
          IFS='-' read fsp lsp
          if [ "$dhost" == "" ] ; then
            if [ "$lsp" != "" ] ; then
              ${IPTABLES} -t filter -A INPUT -p tcp -s ${lhost} --dport ${fsp}:${lsp} -j ${DROP}
              ${IPTABLES} -t filter -A FORWARD -p tcp -s ${lhost} --dport ${fsp}:${lsp} -j ${DROP}
            else
              ${IPTABLES} -t filter -A INPUT -p tcp -s ${lhost} --dport ${port} -j ${DROP}
              ${IPTABLES} -t filter -A FORWARD -p tcp -s ${lhost} --dport ${port} -j ${DROP}
            fi
          else
            if [ "$lsp" != "" ] ; then
              ${IPTABLES} -t filter -A INPUT -p tcp -s ${lhost} -d ${dhost} --dport ${fsp}:${lsp} -j ${DROP}
              ${IPTABLES} -t filter -A FORWARD -p tcp -s ${lhost} -d ${dhost} --dport ${fsp}:${lsp} -j ${DROP}
            else
              ${IPTABLES} -t filter -A INPUT -p tcp -s ${lhost} -d ${dhost} --dport ${port} -j ${DROP}
              ${IPTABLES} -t filter -A FORWARD -p tcp -s ${lhost} -d ${dhost} --dport ${port} -j ${DROP}
            fi
          fi
          echo -n "${rule} "
        }
    }
  done
  echo
fi

if [ "$DENY_HOSTWISE_UDP" != "" ] ; then
  echo -n "Hostwise UDP Denies: "
  for rule in ${DENY_HOSTWISE_UDP} ; do
    echo "$rule" | {
      IFS='><' read lhost port dhost
        echo "$port" | {
          IFS='-' read fsp lsp
          if [ "$dhost" == "" ] ; then
            if [ "$lsp" != "" ] ; then
              ${IPTABLES} -t filter -A INPUT -p udp -s ${lhost} --dport ${fsp}:${lsp} -j ${DROP}
              ${IPTABLES} -t filter -A FORWARD -p udp -s ${lhost} --dport ${fsp}:${lsp} -j ${DROP}
            else
              ${IPTABLES} -t filter -A INPUT -p udp -s ${lhost} --dport ${port} -j ${DROP}
              ${IPTABLES} -t filter -A FORWARD -p udp -s ${lhost} --dport ${port} -j ${DROP}
            fi
          else
            if [ "$lsp" != "" ] ; then
              ${IPTABLES} -t filter -A INPUT -p udp -s ${lhost} -d ${dhost} --dport ${fsp}:${lsp} -j ${DROP}
              ${IPTABLES} -t filter -A FORWARD -p udp -s ${lhost} -d ${dhost} --dport ${fsp}:${lsp} -j ${DROP}
            else
              ${IPTABLES} -t filter -A INPUT -p udp -s ${lhost} -d ${dhost} --dport ${port} -j ${DROP}
              ${IPTABLES} -t filter -A FORWARD -p udp -s ${lhost} -d ${dhost} --dport ${port} -j ${DROP}
            fi
          fi
          echo -n "${rule} "
        }
    }
  done
  echo
fi


# Odd TCP occurances that should be filtered.  Most of these are probably
# [nmap] stealth scans or attempts to circumvent the firewall.
if [ "$BLOCK_ODD_TCP" == "TRUE" ] ; then
  ${IPTABLES} -t filter -N ODDTCP
  ${IPTABLES} -t filter -A INETIN -p tcp --tcp-flags SYN,FIN SYN,FIN -j ODDTCP
  ${IPTABLES} -t filter -A INETIN -p tcp --tcp-flags SYN,RST SYN,RST -j ODDTCP
  ${IPTABLES} -t filter -A INETIN -p tcp --tcp-flags SYN,URG SYN,URG -j ODDTCP
  ${IPTABLES} -t filter -A INETIN -p tcp --tcp-flags ALL ALL -j ODDTCP
  ${IPTABLES} -t filter -A ODDTCP -p tcp -m state --state ESTABLISHED -j RETURN
  ${IPTABLES} -t filter -A ODDTCP -j DROP
fi


# Packets which can't be classified statefully are probably attempts to
# circumvent the firewall.  There's no need to send back an error
# or anything of the like.
echo -n "DROPping invalid packets..."
${IPTABLES} -t filter -A INETIN -m state --state INVALID -j DROP
echo "done"


# ------------------------------------------------------------------------

# Internet jumps to INET chains and DMZ
# Set up INET chains
echo -n "Setting up INET chains: "
for inetdev in ${INET_IFACE} ; do
  ${IPTABLES} -t filter -A INPUT -i $inetdev -j INETIN
  for landev in ${LAN_IFACE} ; do
    ${IPTABLES} -t filter -A FORWARD -i $inetdev -o $landev -j INETIN
  done
  echo -n "INETIN "

  ${IPTABLES} -t filter -A OUTPUT -o $inetdev -j INETOUT
  for landev in ${LAN_IFACE} ; do
    ${IPTABLES} -t filter -A FORWARD -o $inetdev -i $landev -j INETOUT
  done
  echo -n "INETOUT "
  echo
done

if [ "$BRAINDEAD_ISP" = "TRUE" ] ; then
  ${IPTABLES} -t filter -A INETOUT -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
fi

# For now we'll subject the DMZ to the same rules as the internet when going onto the trusted LAN
# And we'll let it go anywhere on the internet
if [ "$DMZ_IFACE" != "" ] ; then
  echo -n "Setting up DMZ Chains: "
  ${IPTABLES} -A OUTPUT -o ${DMZ_IFACE} -j DMZOUT
  ${IPTABLES} -A FORWARD -i ${LAN_IFACE} -o ${DMZ_IFACE} -j DMZOUT
  ${IPTABLES} -A FORWARD -i ${INET_IFACE} -o ${DMZ_IFACE} -j ACCEPT

  echo -n "DMZOUT "
  echo -n "DMZ for Internet Forwarding to INETOUT..."
  ${IPTABLES} -A DMZOUT -j INETOUT

  ${IPTABLES} -A INPUT -i ${DMZ_IFACE} -j DMZIN

  echo -n "DMZIN "
  echo
  echo -n "DMZ for LAN and localhost Forwarding to INETIN..."
  ${IPTABLES} -A FORWARD -i ${DMZ_IFACE} -o ${LAN_IFACE} -j DMZOUT
  ${IPTABLES} -A FORWARD -i ${DMZ_IFACE} -o ${INET_IFACE} -j ACCEPT
  ${IPTABLES} -A DMZOUT -o ${LAN_IFACE} -j INETIN
  echo "done"
  echo -n "done"
fi

# ------------------------------------------------------------------------


# Local traffic to internet or crossing subnets
# This should cover what we need if we don't use masquerading
# Unfortunately, MAC address matching isn't bidirectional (for
#   obvious reasons), so IP based matching is done here
echo -n "Local Traffic Rules: "
if [ "$INTERNAL_LAN" != "" ] ; then
  for subnet in ${INTERNAL_LAN} ; do
    ${IPTABLES} -t filter -A INPUT -s ${subnet} -j ACCEPT
    ${IPTABLES} -t filter -A FORWARD -s ${subnet} -o ! ${INET_IFACE} -i ! ${INET_IFACE} -j ACCEPT
    echo -n "${subnet}:ACCEPT "
  done
fi

# 127.0.0.0/8 used to need an entry in INTERNAL_LAN, but routing of that isn't needed
# so an allow is placed on INPUT so that the computer can talk to itself :)
${IPTABLES} -t filter -A INPUT -i ${LOOP_IFACE} -j ACCEPT
echo -n "loopback:ACCEPT "

# DHCP server magic
# Allow broadcasts from LAN to UDP port 67 (DHCP server)
if [ "$DHCP_SERVER" = "TRUE" ] ; then
  for dev in ${LAN_IFACE} ; do
    ${IPTABLES} -t filter -A INPUT -i $dev -p udp --dport 67 -j ACCEPT
  done
  echo -n "dhcp:ACCEPT"
fi
echo #newline from local traffic rules

if [ "$PROXY" != "" ] ; then
  echo -n "Setting up Transparent Proxy to ${PROXY}: "
  for subnet in ${INTERNAL_LAN} ; do
  echo "$PROXY" | {
    IFS=':' read host port
    if [ "$host" = "localhost" ] || [ "$host" = "127.0.0.1" ] ; then
      ${IPTABLES} -t nat -A PREROUTING -s ${subnet} -p tcp --dport 80 -j REDIRECT --to-port ${port}
      echo -n "${subnet}:PROXY "
    else
      ${IPTABLES} -t nat -A PREROUTING -s ! ${host} -p tcp --dport 80 -j DNAT --to-destination ${host}:${port}
      ${IPTABLES} -t nat -A POSTROUTING -s ${subnet} -d ${host} -j SNAT --to-source ${MY_IP} #Destination changed in PREROUTING
      echo -n "${subnet}:PROXY "
    fi
  }
  done
  echo
fi

if [ "$ALLOW_OUT_TCP" != "" ] ; then
  echo -n "Internet censorship TCP allows: "
  for rule in ${ALLOW_OUT_TCP} ; do
    echo "$rule" | {
      IFS=':' read intip destip dport
            ${IPTABLES} -t filter -A FORWARD -s ${intip} -d ${destip} -p tcp --dport ${dport} -o ${INET_IFACE} -j ACCEPT
      echo -n "${intip}:${destip} "
    }
  done
  echo
fi

# Set up basic NAT if the user wants it
if [ "$MASQ_LAN" != "" ] ; then
  echo -n "Setting up masquerading: "
  if [ "$MAC_MASQ" = "" ] ; then
    for subnet in ${MASQ_LAN} ; do
      ${IPTABLES} -t nat -A POSTROUTING -s ${subnet} -o ${INET_IFACE} -j MASQUERADE
      echo -n "${subnet}:MASQUERADE "
    done
  else
    for address in ${MAC_MASQ} ; do
      ${IPTABLES} -t nat -A POSTROUTING -m mac --mac-source ${address} -o ${INET_IFACE} -j MASQUERADE
      echo -n "${address}:MASQUERADE "
    done
  fi
  echo
fi
if [ "$SNAT_LAN" != "" ] ; then #Static NAT used
  echo -n "Setting up static NAT: "
  if [ "$MAC_SNAT" = "" ] ; then
    for rule in ${SNAT_LAN} ; do
      echo "$rule" | {
        IFS=':' read host destip
        ${IPTABLES} -t nat -A POSTROUTING -s ${host} -o ${INET_IFACE} -j SNAT --to-source ${destip}
        echo -n "${host}:SNAT "
      }
    done
  else
    for rule in ${MAC_SNAT} ; do
      echo "$rule" | {
        IFS=':' read address destip
        ${IPTABLES} -t nat -A POSTROUTING -m mac --mac-source ${address} -o ${INET_IFACE} -j SNAT --to-source ${destip}
        echo -n "${address}:SNAT "
      }
    done
  fi
  echo
fi

#TCP Port-Forwards
if [ "$TCP_FW" != "" ] ; then
  echo -n "TCP Port Forwards: "
  for rule in ${TCP_FW} ; do
    echo "$rule" | {
      IFS=':><' read srcport destport host lhost
        echo "$srcport" | {
          IFS='-' read fsp lsp
          if [ "$lhost" = "" ] ; then
            if [ "$lsp" != "" ] ; then
              echo "$destport" | {
                IFS='-' read fdp ldp
                ${IPTABLES} -t nat -A PREROUTING -i ${INET_IFACE} -p tcp --dport ${fsp}:${lsp} -j DNAT --to-destination ${host}:${destport}
              }
            else
              ${IPTABLES} -t nat -A PREROUTING -i ${INET_IFACE} -p tcp --dport ${srcport} -j DNAT --to-destination ${host}:${destport}
            fi
          else
            if [ "$lsp" != "" ] ; then
              echo "$destport" | {
                IFS='-' read fdp ldp
                ${IPTABLES} -t nat -A PREROUTING -p tcp -d ${lhost} --dport ${fsp}:${lsp} -j DNAT --to-destination ${host}:${destport}
              }
            else
              ${IPTABLES} -t nat -A PREROUTING -p tcp -d ${lhost} --dport ${srcport} -j DNAT --to-destination ${host}:${destport}
            fi
          fi
          echo -n "${rule} "
        }
    }
  done
  echo
fi

#UDP Port Forwards
if [ "$UDP_FW" != "" ] ; then
  echo -n "UDP Port Forwards: "
  for rule in ${UDP_FW} ; do
    echo "$rule" | {
      IFS=':><' read srcport destport host lhost
        echo "$srcport" | {
          IFS='-' read fsp lsp
          if [ "$lhost" = "" ] ; then
            if [ "$lsp" != "" ] ; then
              echo "$destport" | {
                IFS='-' read fdp ldp
                ${IPTABLES} -t nat -A PREROUTING -i ${INET_IFACE} -p udp --dport ${fsp}:${lsp} -j DNAT --to-destination ${host}:${destport}
              }
            else
              ${IPTABLES} -t nat -A PREROUTING -i ${INET_IFACE} -p udp --dport ${srcport} -j DNAT --to-destination ${host}:${destport}
            fi
          else
            if [ "$lsp" != "" ] ; then
              echo "$destport" | {
                IFS='-' read fdp ldp
                ${IPTABLES} -t nat -A PREROUTING -p udp -d ${lhost} --dport ${fsp}:${lsp} -j DNAT --to-destination ${host}:${destport}
              }
            else
              ${IPTABLES} -t nat -A PREROUTING -p udp -d ${lhost} --dport ${srcport} -j DNAT --to-destination ${host}:${destport}
            fi
          fi
          echo -n "${rule} "
        }
    }
  done
  echo
fi

# IP protocol forwards
if [ "$PROTO_FW" != "" ] ; then
  echo -n "IP Protocol Forwards: "
  for rule in ${PROTO_FW} ; do
    echo "$rule" | {
      IFS='><' read proto host lhost
      if [ "$lhost" = "" ] ; then
        ${IPTABLES} -t nat -A PREROUTING -i ${INET_IFACE} -p $proto -j DNAT --to-destination ${host}
      else
        ${IPTABLES} -t nat -A PREROUTING -i ${INET_IFACE} -d ${lhost} -p $proto -j DNAT --to-destination ${host}
      fi
      echo -n "${rule} "
    }
  done
  echo
fi

# =================================================
# -------------------ICMP rules--------------------
# =================================================

if [ "$BAD_ICMP" != "" ] ; then
  echo -n "${DROP}ing ICMP messages specified in BAD_ICMP..."
  for message in ${BAD_ICMP} ; do
    ${IPTABLES} -t filter -A INETIN -p icmp --icmp-type ${message} -j ${DROP}
    echo -n "${message} "
  done
  echo
fi

# Flood "security"
# You'll still respond to these if they comply with the limits (set in config)
# There is a more elegant way to set this using sysctl, however this has the
#   advantage that the kernel ICMP stack never has to process it, lessening
# the chance of a very serious flood overloading your kernel.
# This is just a packet limit, you still get the packets on the interface and
#    still may experience lag if the flood is heavy enough
echo -n "Flood limiting: "
# Ping Floods (ICMP echo-request)
${IPTABLES} -t filter -A INETIN -p icmp --icmp-type echo-request -m limit --limit ${PING_FLOOD} -j ACCEPT
${IPTABLES} -t filter -A INETIN -p icmp --icmp-type echo-request -j ${DROP}
echo -n "ICMP-PING "
echo

echo -n "Allowing the rest of the ICMP messages in..."
${IPTABLES} -t filter -A INETIN -p icmp ! --icmp-type echo-request -j ACCEPT
echo "done"



# ================================================================
# ------------Allow stuff we have chosen to allow in--------------
# ================================================================


# Hostwise allows
if [ "$ALLOW_HOSTWISE_TCP" != "" ] ; then
  echo -n "Hostwise TCP Allows: "
  for rule in ${ALLOW_HOSTWISE_TCP} ; do
    echo "$rule" | {
      IFS='><' read lhost port dhost
        echo "$port" | {
          IFS='-' read fsp lsp
          if [ "$dhost" == "" ] ; then
            if [ "$lsp" != "" ] ; then
              ${IPTABLES} -t filter -A INETIN -p tcp -s ${lhost} --dport ${fsp}:${lsp} -j TCPACCEPT
            else
              ${IPTABLES} -t filter -A INETIN -p tcp -s ${lhost} --dport ${port} -j TCPACCEPT
            fi
          else
                                                if [ "$lsp" != "" ] ; then
                                                        ${IPTABLES} -t filter -A INETIN -p tcp -s ${lhost} -d ${dhost} --dport ${fsp}:${lsp} -j TCPACCEPT
                                                else
                                                        ${IPTABLES} -t filter -A INETIN -p tcp -s ${lhost} -d ${dhost} --dport ${port} -j TCPACCEPT
                                                fi
          fi
                            echo -n "${rule} "
        }
    }
  done
  echo
fi

if [ "$ALLOW_HOSTWISE_UDP" != "" ] ; then
  echo -n "Hostwise UDP Allows: "
  for rule in ${ALLOW_HOSTWISE_UDP} ; do
    echo "$rule" | {
      IFS='><' read lhost port dhost
        echo "$port" | {
          IFS='-' read fsp lsp
          if [ "$dhost" == "" ] ; then
            if [ "$lsp" != "" ] ; then
              ${IPTABLES} -t filter -A INETIN -p udp -s ${lhost} --dport ${fsp}:${lsp} -j UDPACCEPT
            else
              ${IPTABLES} -t filter -A INETIN -p udp -s ${lhost} --dport ${port} -j UDPACCEPT
            fi
          else
            if [ "$lsp" != "" ] ; then
              ${IPTABLES} -t filter -A INETIN -p udp -s ${lhost} -d ${dhost} --dport ${fsp}:${lsp} -j UDPACCEPT
            else
              ${IPTABLES} -t filter -A INETIN -p udp -s ${lhost} -d ${dhost} --dport ${port} -j UDPACCEPT
            fi
          fi
          echo -n "${rule} "
        }
    }
  done
  echo
fi

if [ "$ALLOW_HOSTWISE_PROTO" != "" ] ; then
  echo -n "Hostwise IP Protocol Allows: "
  for rule in ${ALLOW_HOSTWISE_PROTO} ; do
    echo "$rule" | {
      IFS='><' read lhost proto dhost
        if [ "$dhost" == "" ] ; then
          ${IPTABLES} -t filter -A INETIN -p ${proto} -s ${lhost} -j ACCEPT
        else
          ${IPTABLES} -t filter -A INETIN -p ${proto} -s ${lhost} -d ${dhost} -j ACCEPT
        fi
        echo -n "${rule} "
    }
  done
  echo
fi

echo -n "Allowing established outbound connections back in..."
${IPTABLES} -t filter -A INETIN -m state --state ESTABLISHED -j ACCEPT
echo "done"

# RELATED on high ports only for security
echo -n "Allowing related inbound connections..."
${IPTABLES} -t filter -A INETIN -p tcp --dport 1024:65535 -m state --state RELATED -j TCPACCEPT
${IPTABLES} -t filter -A INETIN -p udp --dport 1024:65535 -m state --state RELATED -j UDPACCEPT
echo "done"


# =================================================
# ----------------Packet Mangling------------------
# =================================================


# TTL mangling
# This is probably just for the paranoid, but hey, isn't that what
# all security guys are? :)
if [ "$TTL_SAFE" != "" ] ; then
  ${IPTABLES} -t mangle -A PREROUTING -i ${INET_IFACE} -j TTL --ttl-set ${TTL_SAFE}
fi

# Type of Service mangle optimizations (the ACTIVE FTP one will only work for uploads)
# Most routers tend to ignore these, it's probably better to use
# QoS.  A packet scheduler like HTB is much more efficient
# at assuring bandwidth availability at the local end than
# ToS is.
if [ "$MANGLE_TOS_OPTIMIZE" = "TRUE" ] ; then
  echo -n "Optimizing traffic: "
  ${IPTABLES} -t mangle -A OUTPUT -p tcp --dport 23 -j TOS --set-tos Minimize-Delay
  echo -n "telnet "
  ${IPTABLES} -t mangle -A OUTPUT -p tcp --dport 22 -j TOS --set-tos Minimize-Delay
  echo -n "ssh "
  ${IPTABLES} -t mangle -A OUTPUT -p tcp --dport 20 -j TOS --set-tos Minimize-Cost
  echo -n "ftp-data "
  ${IPTABLES} -t mangle -A OUTPUT -p tcp --dport 21 -j TOS --set-tos Minimize-Delay
  echo -n "ftp-control "
  ${IPTABLES} -t mangle -A OUTPUT -p udp --dport 4000:7000 -j TOS --set-tos Minimize-Delay
  echo -n "diablo2 "
  echo
fi

# What to do on those INET chains when we hit the end
echo -n "Setting up INET policies: "
# Drop if we cant find a valid inbound rule.
${IPTABLES} -t filter -A INETIN -j ${DROP}
echo -n "INETIN:${DROP} "
# We can send what we want to the internet
${IPTABLES} -t filter -A INETOUT -j ACCEPT
echo -n "INETOUT:ACCEPT "
echo

# All done!
echo "Done loading the firewall!"
