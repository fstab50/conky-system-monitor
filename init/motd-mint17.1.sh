#!/bin/bash
#
# Name:   motd.sh
# Usage:  this script must be located at /etc/profile.d/motd.sh
# Requires: figlet
#
HOSTNAME=`uname -n`
KERNEL=`uname -r`
CPU=$(cat /proc/cpuinfo | grep 'model name' | tail -1 | cut -c 14-60)
ARCH=`uname -m`
UTIME=`uptime | sed -e 's/ [0-9:]* up />/' -e 's/,.*//'`

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

echo ""
echo "$R===============================================================" 
echo ""                                                           
echo  "       $W HOST   : ${BOLD}${green}$HOSTNAME${reset}${UNBOLD} "             
echo  "       $R ARCH   : ${yellow}$ARCH${reset}        " 
echo  "       $R KERNEL : ${yellow}$KERNEL${reset}      " 
echo  "       $R CPU    : ${yellow}$CPU${reset}         " 
echo  "       $R Uptime : ${yellow}$UTIME${reset}       "
echo ""
#echo "   "$HOSTNAME Linux | figlet -f smslant -t 
echo  "   "Linux Mint 17.1 | figlet -f shadow 
echo  "$R==============================================================="
echo ""
# 
# end motd.sh
#
# Disk Usage (optional)
# df -h | egrep '(Filesystem)|(/dev/[a-m][d,m,s])'
