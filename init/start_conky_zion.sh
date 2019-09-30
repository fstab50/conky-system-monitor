#!/bin/bash
#
# This file called by gnome session startup to start conky system monitoring for user session
#

# vars
PYTHON_DIR=~/git/scripts-host/library-python

# start hddtemp daemon
sudo hddtemp -d /dev/sda

# start conky
sleep 10 

# find out what monitor is connected
RES_INFO=$(python $PYTHON_DIR/getResolution.py | grep "current" | sed -r 's/^([^.]+).*$/\1/; s/^[^0-9]*([0-9]+).*$/\1/')

case $RES_INFO in
  1366)
        # built-in monitor, 1366x768
        conky --config=/home/blake/.conky/conkyrc_zion-laptop_1366x768 2>/dev/null
	;;  
  1400)
	# Lewisville office monitor setup.  Defaulted to 1366x768 for now
        conky --config=/home/blake/.conky/conkyrc_zion-laptop_1366x768 2>/dev/null
	;;  
  1920)
        # home external monitor
        conky --config=/home/blake/.conky/conkyrc_zion-laptop_1920x1080 2>/dev/null
        #echo "start conky for 1920x1080"
	;;
  *)
	# unknown defaults to conky for builti-in resolution 
        conky --config=/home/blake/.conky/conkyrc_zion-laptop_1366x768 2>/dev/null
	;;
esac

# <-- end -->

exit 0
