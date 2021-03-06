#!/bin/bash
#
# Name:   motd.sh
# Usage:  this script must be located at /etc/profile.d/motd.sh
# Requires: figlet
#

# print normal motd
HOSTNAME=`uname -n`
KERNEL=`uname -r`
CPU=$(cat /proc/cpuinfo | grep 'model name' | tail -1 | cut -c 14-60)
ARCH=`uname -m`
UTIME=`uptime | sed -e 's/ [0-9:]* up />/' -e 's/,.*//'`
TMPDIR='/tmp'

# set colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
reset=$(tput sgr0)

# bold codes
BOLD=`tput bold`
UNBOLD=`tput sgr0`

function indent02() { sed 's/^/  /'; }

echo ""
echo "$R==============================================================="
echo ""
echo  "       $W HOST   : ${BOLD}${blue}$HOSTNAME${reset}${UNBOLD} "
echo  "       $R ARCH   : ${yellow}$ARCH${reset}        "
echo  "       $R KERNEL : ${yellow}$KERNEL${reset}      "
echo  "       $R CPU    : ${yellow}$CPU${reset}         "
echo  "       $R Uptime : ${yellow}$UTIME${reset}       "
echo ""
#echo "   "$HOSTNAME Linux | figlet -f smslant -t
echo  "   "Linux Mint 18.3 | figlet -f shadow
echo  "$R==============================================================="
echo ""


# Disk Usage (optional)
printf "  %s\n" "$(/bin/df -h | egrep '(Filesystem)|(/dev/[a-m][d,m,s])')"
/bin/df -h | grep sda | indent02
printf "\n"
exit 0
#
# end motd.sh
#
