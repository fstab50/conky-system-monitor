#!/usr/bin/env bash

###############################################################################
#                                                                             #
#   This file called by systemd autostart configuration at boot               #
#   to start conky system monitoring for user session.                        #
#                                                                             #
#   See ~/.config/autostart or autostart/ directory in the                    #
#   conky-system-monitor git repository                                       #
#                                                                             #
###############################################################################

pkg=$(basename $0)
logger=$(which logger)

#
# This file called by gnome session startup to start conky system monitoring for user session
#

# test if previous init
logger "[INFO]: pkg name detect is: $pkg"
run_status=$(ps -ef | grep $pkg | grep -v grep 2>/dev/null)
echo -e logger "[INFO]: run status detect is: $run_status"

if [[ $run_status ]]; then
    logger "[INFO]: $pkg already running in the environment. Exit"
#    exit 0    # pkg running
fi

# vars
PYTHON_DIR="/home/blake/git/scripts-host/library-python"


#------------------------------------------------------------------------------
#   SSD / Harddrive Temp Monitoring                                           |
#------------------------------------------------------------------------------

# start hddtemp daemon (Not generally effective with SSD drives, only HD's)
#sudo hddtemp -d /dev/sda


#------------------------------------------------------------------------------
#   Startup Delay (launch x)                                                  |
#------------------------------------------------------------------------------

# start conky
sleep 20


#------------------------------------------------------------------------------
#   Print Conky output with appropriate screen                                |
#   resolution configuration                                                  |
#------------------------------------------------------------------------------

PYTHON_PATH=$(which python)

# find out what monitor is connected
RES_INFO=$($PYTHON_PATH $PYTHON_DIR/getResolution.py | grep "current" |  awk '{print $1}')

case $RES_INFO in
    1920)
        # home external monitor
        conky --config=/home/blake/.conky/conkyrc-libra_1920x1080 2>/dev/null
	;;
    2560)
  	# Lewisville office monitor setup.  Defaulted to 1366x768 for now
        conky --config=/home/blake/.conky/conkyrc-libra_2560x1440 2>/dev/null
  	;;
    *)
        # unknown defaults to conky for builti-in resolution
        conky --config=/home/blake/.conky/conkyrc-libra_1920x1080 2>/dev/null
	;;
esac

# <-- end -->

exit 0
