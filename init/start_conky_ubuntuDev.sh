#!/usr/bin/env bash
#
# This file called by gnome session startup to start conky system monitoring for user session
#
# >>>>    NOT USED -- SEE ~/.config/autostart/conky.desktop  <<<<<<<<
#
###########################################################################################

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
PYTHON_DIR="$HOME/git/scripts-host/library-python"

# start hddtemp daemon
#sudo hddtemp -d /dev/sda     # ssd

# start conky
sleep 10

PYTHON_PATH=$(which python)

# find out what monitor is connected
RES_INFO=$($PYTHON_PATH $PYTHON_DIR/getResolution.py | grep "current" |  awk '{print $1}')

case $RES_INFO in
    1920)
        # home external monitor
        conky --config=/home/blake/.conky/conkyrc-ubuntuDev_1920x1080 2>/dev/null
        ;;
    2560)
  	    # office monitor setup.  Defaulted to 1366x768 for now
        conky --config=/home/blake/.conky/conkyrc-ubuntuDev_2560x1440 2>/dev/null
  	     ;;
    *)
        # unknown defaults to conky for builti-in resolution
        conky --config=/home/blake/.conky/conkyrc-ubuntuDev_2560x1440 2>/dev/null
	       ;;
esac

# <-- end -->

exit 0
