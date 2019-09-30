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
# The different colours as variables
#W="\033[01;37m"
#B="\033[01;34m"
#R="\033[01;31m" 
#X="\033[00;37m"
echo ""
echo "$R===============================================================" 
echo ""                                                           
echo  "       $W Welcome to$B $HOSTNAME               "             
echo  "       $R ARCH   $W: $ARCH                     " 
echo  "       $R KERNEL $W: $KERNEL                   " 
echo  "       $R CPU    $W: $CPU                      " 
echo  "       $R Uptime $W: $UTIME                    "
echo ""
#echo "   "$HOSTNAME Linux | figlet -f smslant -t 
echo  "   "Fedora Linux | figlet -f smslant 
echo  "$R==============================================================="
echo ""
# 
# end motd.sh
#
# Disk Usage (optional)
# df -h | egrep '(Filesystem)|(/dev/[a-m][d,m,s])'
