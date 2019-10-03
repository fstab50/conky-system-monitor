#!/usr/bin/env bash
#
# This file called by gnome session startup to start conky system monitoring for user session
#

pkg=$(basename $0)
logger=$(which logger)
_home=$(echo $HOME)
PYTHON2_PATH=$(which python)
DELAY=12     # seconds

# --- declarations ------------------------------------------------------------


function host_keyword(){
    ##
    ## finds hostname keyword used to id conky configuration file
    ##
    local host

    host=$(hostname)

    case $host in

        *libra*)
            echo 'libra'
            return 0
            ;;

        ubuntu1*)
            echo 'gemini'
            return 0
            ;;

        *scorpio*)
            echo 'scorpio'
            return 0
            ;;

        *)
            logger "[WARN]: Hostname keyword cannot be identified. Exit"
            exit 1
            ;;
    esac
    #
    # <-- end function host_keyword -->
}


# global vars
KEYWORD=$(host_keyword)
INIT_DIR="$_home/git/conky-system-monitor"
CONFIG_DIR="${INIT_DIR}/${KEYWORD}"

# test if previous init
logger "[INFO]: pkg name detect is: $pkg"
logger "[INFO]: KEYWORD = $KEYWORD"
logger "[INFO]: INIT_DIR = $INIT_DIR"
logger "[INFO]: CONFIG_DIR = $CONFIG_DIR"

# estimate conky running status
run_status=$(ps -ef | grep $pkg | grep -v grep 2>/dev/null)
echo -e logger "[INFO]: run status detect is: $run_status"

if [[ $run_status ]]; then
    logger "[INFO]: $pkg already running in the environment. Exit"
#    exit 0    # pkg running
fi


# start hddtemp daemon
# sudo hddtemp -d /dev/sda

# start conky
sleep $DELAY

# find out what monitor is connected
RES_INFO=$($PYTHON2_PATH $INIT_DIR/getResolution.py | grep "current" |  awk '{print $1}')

case $RES_INFO in
    1366)
        logger "[INFO]: 1366x765 resolution identified, init appropriate conkyrc"
        conky --config=${CONFIG_DIR}/conkyrc-${KEYWORD}_1366X768 2>/dev/null &
        ;;

    1920)
        logger "[INFO]: 1920x1080 resolution identified, init appropriate conkyrc"
        conky --config=${CONFIG_DIR}/conkyrc-${KEYWORD}_1920x1080 2>/dev/null &
	    ;;

    2560)
        logger "[INFO]: 2560x1440 resolution identified, init appropriate conkyrc"
        conky --config=${CONFIG_DIR}/conkyrc-${KEYWORD}_2560x1440 2>/dev/null &
  	    ;;

    *)
        logger "[INFO]: Unknown screen resolution identified, starting default conky config"
        # unknown defaults to conky for builti-in resolution
        conky --config=${CONFIG_DIR}/conkyrc-${KEYWORD}_1920x1080 2>/dev/null &
	    ;;
esac

# <-- end -->

exit 0
